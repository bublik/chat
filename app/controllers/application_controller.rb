class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_action :set_locale
  before_filter :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token, if: :json_request?
  layout :authorized_layout

  protected

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_subdomain || extract_locale_from_accept_language_header || I18n.default_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :password, :password_confirmation, :current_password) }
  end

  def session_debug
    return unless Rails.env.development?
    logger.debug("SESSION"+session.inspect)
  end

  def json_request?
    request.format.json?
  end

  private

  def extract_locale_from_accept_language_header
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  # Get locale code from request subdomain (like http://it.application.local:3000)
  # You have to put something like:
  #   127.0.0.1 ru.application.local
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.include?(parsed_locale.to_s.to_sym) ? parsed_locale : nil
  end


  def authorized_layout
    agent_signed_in? ? 'management' : 'application'
  end

  def after_sign_in_path_for(resource)
    logger.debug("RESOURCE #{resource.inspect}")
    resource.kind_of?(Agent) ? management_index_path : root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    logger.debug("RESOURCE #{resource_or_scope.inspect}")
    root_path
  end
end
