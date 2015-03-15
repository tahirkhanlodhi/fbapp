class Users::SessionsController < Devise::SessionsController
  require 'securerandom'
  layout "application"
  skip_before_filter  :verify_authenticity_token


  def create
    begin
      puts "________________________________________________________"
      puts "________________________Sign In_________________________"
      puts "________________________________________________________"
      puts "000000000000000000000",params.inspect
      puts "............params[:device_token]............",params[:user][:device_token].inspect
      puts "............params[:user]............",params[:user]
      puts "............request.format(request............",request.format(request)
      puts "............request.format............",request.format
      if request.format(request) == '*/*'
        #params[:device_token] = "askldjfh3a2s1fgasdf2s1dfsd2fasdf1"
        resource = warden.authenticate(:scope => resource_name, :recall => "#{controller_path}#failure")
        if (resource.present?)
          sign_out(current_user) if current_user.present?
          puts "............resource.inspect............",resource.inspect
          random_str = SecureRandom.hex
          puts "............random_str............",random_str
          resource.update_attributes(:device_token => params[:user][:device_token], :session_token => random_str)
          puts "............resource.inspect............",resource.inspect
          workoutfitcoins = Workoutfitcoin.all.where(:user_id => resource.id)
          total_coins = workoutfitcoins.sum(:bitcoins) if workoutfitcoins.length > 0
          return render :json => {:success => "true", :user => {:id => resource.id,:total_coins => total_coins.present? ? total_coins : 0, :first_name => resource.first_name, :last_name => resource.last_name,:age => resource.age, :sex => resource.sex,:weight => resource.weight,:email => resource.email, :token => resource.session_token}, :message => "Signed in Successfully!"}
          #:id => resource.id,  return render :json => {:success => "true", :message => "Logged in Successfully !", :data => after_sign_in_data(resource, random_str)}
        else
          render :json => {:success => "false", :errors => "Login failed"}
        end
      else
        p "(((((((((((((else[params])))))))))))))))", params.inspect
        @user = User.where(:email => params[:user][:email]).first
        if (@user && @user.is_admin == true)
          super
        else
          redirect_to "/"
        end
      end
    rescue Exception => e
      return render :json => {:success => "false", :message => "#{e.message}"}
    end
  end

  def destroy
    puts "********************+++++++++++++Sign Out++++++++++++********************",params.inspect
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to_on_destroy
  end

  def respond_to_on_destroy
    if request.format(request) == '*/*'
      render :json => {:success => "true", :message => "Sign out successfully"}
    else
      respond_to do |format|
        format.all { head :no_content }
        format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }

      end
    end
  end

  def failure
    return render :json => {:success => "false", :errors => "Login failed."}
  end

# before_filter :configure_sign_in_params, only: [:create]

# GET /resource/sign_in
# def new
#   super
# end

# POST /resource/sign_in
# def create
#   super
# end

# DELETE /resource/sign_out
# def destroy
#   super
# end

# protected

# You can put the params you want to permit in the empty array.
# def configure_sign_in_params
#   devise_parameter_sanitizer.for(:sign_in) << :attribute
# end

# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
