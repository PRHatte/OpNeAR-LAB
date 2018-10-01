# ApplicationController is the base controller for all the controllers in the project
# It defines many helpful methods that most of the other controllers use. 
# One such helper method is one called "require_signed_in!" which can be used
# by controllers to ensure that a user is signed in.

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  # TODO ML: Look at putting this into a module?
  def user_signed_in?
    !current_user.blank?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def sign_in_user(user)
    session[:user_id] = user.try(:id)
  end

  def log_out
    session[:user_id] = nil
  end

  def require_signed_out!
    redirect_to user_path(current_user) if user_signed_in?
  end

  def require_signed_in!
    redirect_to root_path unless user_signed_in?
  end

  def require_admin!
    redirect_to user_path(current_user) unless current_user.has_permission_level('admin')
  end

  helper_method :user_signed_in?
  helper_method :current_user

  # TODO: It might be possible to pull these SAML specific methods out into a module
  def saml_settings
    # Ripped from https://github.com/onelogin/ruby-saml
    settings = OneLogin::RubySaml::Settings.new

    # When disabled, saml validation errors will raise an exception.
    settings.soft = true

    # IDP Settings
    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
    # Returns OneLogin::RubySaml::Settings prepopulated with idp metadata
    settings = idp_metadata_parser.parse_remote(ENV['SAML_METADATA_URL'] || "https://idp.utdallas.edu/idp/shibboleth", false)

    settings.assertion_consumer_service_url = "http://openear.local:3000/sessions"
    # Stupid library
    # settings.idp_entity_id                  = "https://#{host}/metadata"
    settings.issuer                         = "http://#{host}/metadata"

    # Security Settings
    settings.security[:authn_requests_signed]   = true    # Enable or not signature on AuthNRequest  
    settings.security[:want_assertions_signed]  = true     # Enable or not the requirement of signed assertion
    settings.security[:metadata_signed]         = true     # Enable or not signature on Metadata
    settings.security[:want_assertions_encrypted] = true
    settings.security[:digest_method] = XMLSecurity::Document::SHA1
    settings.security[:signature_method] = XMLSecurity::Document::RSA_SHA1
    # Cert settings
    settings.certificate = IO.read(cert_path)
    settings.private_key = IO.read(private_key_path)

    settings.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
    settings.authn_context = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

    # Optional. Describe according to IdP specification (if supported) which attributes the SP desires to receive in SAMLResponse.
    settings.attributes_index = 1
    # Optional. Describe an attribute consuming service for support of additional attributes.
    settings.attribute_consuming_service.configure do
      service_name "ProNet"
      service_index 1
      add_attribute name: "urn:oid:1.3.6.1.4.1.5923.1.1.1.6", friendly_name: "eduPersonPrincipleName"
      add_attribute name: "email-nameid"
    end

    settings
  end

  def host
    "openear.utdallas.edu"
  end

  private

  def redirect_host
    "#{request.host}" #:#{request.port}"
  end

  def certs_dir
    Rails.root + "config" + "certs"
  end

  def cert_path
    certs_dir + "publickey.cer"
  end

  def private_key_path
    certs_dir + "private.key"
  end
end