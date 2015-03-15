class Users::RegistrationsController < Devise::RegistrationsController
  layout 'application'

  def new
    resource = build_resource({})
    respond_with resource
  end

  def create

  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
  end


  #def create
  #  $read = user_params
  #  $role = params["role"]
  #  $country = params[:country]
  #  $address = {:post_code => params[:postal_code], :city => params[:locality],
  #              :state => params[:administrative_area_level_1], :country => params[:country], :street_address => params[:name], :latitude => params[:lat], :longitude => params[:lng]}
  #
  #  if params[:country] == 'United Kingdom' || params[:country] == 'GB' || params[:country] == 'UK'
  #
  #    $show = true;
  #    redirect_to "/admin/register_merchant_form2"
  #  else
  #    @user = SubscribedUser.new
  #    @user.name = params[:user][:name]
  #    @user.email = params[:user][:email]
  #    @user.address_line = params[:user][:profile_attributes][:address_line1]
  #
  #    if @user.save
  #      @user.update_attributes(:post_code => params[:postal_code], :city => params[:locality],
  #                              :state => params[:administrative_area_level_1], :country => params[:country], :street_address => params[:name])
  #      #subscribeduser.update_attribute(:address, params[:address_line1])
  #      $show = false;
  #      redirect_to "/homes/country_error"
  #    end
  #  end
  #end

  #def update_user
  #  $read = user_params
  #  $role = params["role"]
  #  $country = params[:country]
  #  $address = {:post_code => params[:postal_code], :city => params[:locality],
  #              :state => params[:administrative_area_level_1], :country => params[:country], :street_address => params[:name], :latitude => params[:lat], :longitude => params[:lng]}
  #
  #  if params[:country] == 'United Kingdom' || params[:country] == 'GB' || params[:country] == 'UK'
  #
  #    redirect_to "/admin/register_merchant_form2"
  #  else
  #    @user = SubscribedUser.new
  #    @user.name = params[:user][:name]
  #    @user.email = params[:user][:email]
  #    @user.address_line = params[:user][:profile_attributes][:address_line1]
  #
  #    if @user.save
  #      @user.update_attributes(:post_code => params[:postal_code], :city => params[:locality],
  #                              :state => params[:administrative_area_level_1], :country => params[:country], :street_address => params[:name])
  #      #subscribeduser.update_attribute(:address, params[:address_line1])
  #      redirect_to "/homes/country_error"
  #    end
  #  end
  #end

  #private

  #def user_params
  #  params.require(:user).permit(:name, :email, :password, :password_confirmation, :unique_name, :admin_username, :confirmed_at, :profile_attributes => [:first_name, :last_name, :age, :gender, :post_code, :url, :address_line1, :id, :country, :city, :street_address, :state])
  #end
  #
  #def subscribed_user_params
  #  params.require(:subscribed_user).permit(:name, :email, :address)
  #end

  # before_filter :configure_sign_up_params, only: [:create]
  # before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
