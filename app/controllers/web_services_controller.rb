class WebServicesController < ApplicationController

  skip_before_filter :authenticate_user!
  before_filter :check_session_create, :except => [:sign_up, :sign_up_facebook,  :test_mailer, :test_sign_up_facebook]
  skip_before_filter :verify_authenticity_token
  #require 'json_builder'
  respond_to :json, :html

  def index
  end

  def sign_up_facebook
    puts "+++++++++++++++++++facebook_sign_up+++++++++++++++++++"
    puts "000000000000000000000", params.inspect
    puts "111111111111111111111", params[:user][:device_token]
  begin
    if request.format(request) == '*/*'
      if params[:facebook_id].present?
        @user = User.where(:facebook_id => params[:facebook_id]).first
        if @user.present?
          #if @user.sign_in_count == 0
          #  flag = true
          #else
          #  flag = false
          #end
          render :json => {:success => "true", :message => "signed in successfully", :user => {:id => @user.id, :email => @user.email, :token => @user.session_token, }}
          @user.update_attributes(:device_token => params[:user][:device_token])
        else
          random_str = SecureRandom.hex
          @user = User.new(:email => params[:user][:email], :password => params[:user][:password], :facebook_id => params[:facebook_id], :device_token => params[:user][:device_token], :session_token => random_str)
          if @user.save
            #if @user.sign_in_count == 0
            #  flag = true
            #else
            #  flag = false
            #end
            render :json => {:success => "true", :message => "user has been successfully created", :user => {:id => @user.id, :email => @user.email, :token => @user.session_token, }}
          else
            render :json => {:success => "false", :message => "cant create user"}
          end
        end
      else
        render :json => {:success => "false", :message => "cant create user facebook id does not exist"}
      end
    end
  rescue Exception => e
    return render :json => {:success => "false", :message => "#{e.message}"}
  end
  end


  def facebook_sign_up
    puts "+++++++++++++++++++facebook_sign_up+++++++++++++++++++"
    puts "000000000000000000000", params.inspect
    puts "111111111111111111111", params[:user][:device_token]
    begin
      if request.format(request) == '*/*'
        if params[:facebook_id].present?
          @user = User.where(:facebook_id => params[:facebook_id]).first
          if @user.present?
            if @user.sign_in_count == 0
              flag = true
            else
              flag = false
            end
            render :json => {:success => "true", :message => "signed in successfully",:is_braintree_info_added => @user.merchant_id.present? ? "true" : "false", :user => {:id => @user.id,:sign_up_first_time => flag, :name => @user.name, :username => @user.username, :email => @user.email, :street_address => @user.street_address, :city => @user.city, :state => @user.state, :zip_code => @user.zip_code, :token => @user.session_token, :profile => {:user_id => @user.id, :about_yourself => @user.profile.about_yourself, :phone_number => @user.profile.phone_number, :distance => @user.profile.distance, :location_status => @user.profile.location_status,:push_notifications => @user.profile.push_notifications, :profile_image => {:pic_url => @user.profile.profile_image.present? ? @user.profile.profile_image.pic.url : ""}}}}
            @user.update_attributes(:sign_in_count => @user.sign_in_count + 1, :device_token => params[:user][:device_token])
          else
            random_str = SecureRandom.hex
            @user = User.new(:name => params[:user][:name], :username => params[:user][:username], :email => params[:user][:email], :password => params[:user][:password], :facebook_id => params[:facebook_id], :device_token => params[:user][:device_token], :session_token => random_str)
            if @user.save
              if @user.sign_in_count == 0
                flag = true
              else
                flag = false
              end
              @profile = Profile.create(:about_yourself => params[:user][:profile][:about_yourself], :phone_number => params[:user][:profile][:phone], :distance => params[:user][:profile][:distance], :user_id => @user.id) if @user.present?
              create_customer_to_braintree(@user)
              render :json => {:success => "true", :message => "user has been successfully created",:is_braintree_info_added => @user.merchant_id.present? ? "true" : "false", :user => {:id => @user.id,:sign_up_first_time => flag, :name => @user.name, :username => @user.username, :email => @user.email, :street_address => @user.street_address, :city => @user.city, :state => @user.state, :zip_code => @user.zip_code, :token => @user.session_token, :profile => {:user_id => @user.id, :about_yourself => @profile.about_yourself, :phone_number => @profile.phone_number, :distance => @profile.distance, :location_status => @user.profile.location_status, :push_notifications => @user.profile.push_notifications,:profile_image => {:pic_url => @user.profile.profile_image.present? ? @user.profile.profile_image.pic.url : ""}}}}
              @user.update_attributes(:sign_in_count => @user.sign_in_count + 1)
            else
              render :json => {:success => "false", :message => "cant create user"}
            end
          end
        else
          render :json => {:success => "false", :message => "cant create user facebook id does not exist"}
        end
      end
    rescue Exception => e
      return render :json => {:success => "false", :message => "#{e.message}"}
    end

  end



  def check_session_create
    #params[:token] = "a0b1a417b7fe17a0f9c948a5c05f70751"
    puts "_________________________check_session_create_________________________"
    if params[:token].present?
      @user = User.find_by_session_token(params[:token])
      if @user.present?
        puts "...........user exists.............."
        return true
      else
        puts "...........user does not exist..........."
        render :json => {:success => "false", :errors => " authentication failed(User Does,nt Exist)..."}
      end
    else
      puts "...........params token not present..........."
      render :json => {:success => "false", :errors => "authentication failed(Token Does,nt Exixt)..."}
    end
  end


end
