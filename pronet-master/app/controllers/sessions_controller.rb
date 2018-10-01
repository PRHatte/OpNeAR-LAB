# This class handles all log in and log out information. 
# 

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_signed_out!, except: :destroy

  def create
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], settings: saml_settings, allowed_clock_drift: 10.seconds)

    # Check to see if there are any errors 
    if response.is_valid?(true)
      email = response.name_id # this is the email attribute apparently
      @user = User.find_by(email: email)

      # If we didn't find a user, lets create a user
      unless @user
        @user = User.new(email: email) # todo: add permissions here

        if !@user.save
          redirect_to new_session_path, flash: { error: "There was an error creating your user. Please contact the administrator" }
          return # we have to return here because it will fall through and cause another redirect, which is not allowed
        end
      end
      
      # Once it saved, we can set a cookie and sign them in
      sign_in_user(@user)
      # now we have a valid user
      redirect_to @user, flash: { notice: "You have been signed in" }
    else
      redirect_to root_path, flash: { error: response.errors }
    end
  end

  def new
    # This is for development only really. We don't need to use SAML when we are hosting locally.
    if ENV['AUTHENTICATION_ENABLED']
      request = OneLogin::RubySaml::Authrequest.new
      redirect_to(request.create(saml_settings))
    else
      # Development branch only
      @user = User.first || User.create(email: "temporary@utdallas.edu", permission_level: 'super_admin') # really awful hack
      sign_in_user(@user)
      redirect_to @user
    end
  end

  def destroy
    log_out # this ditches the user session

    # Note: UTD's SAML does not have a log out URL which means they choose to not implement that,
    # This is fine, but we should still unset the cookie from the browser if we can.

    redirect_to root_path, flash: { notice: "You have been signed out." }
  end
end