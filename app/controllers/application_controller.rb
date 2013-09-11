class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?
  #before_filter :session_debug

  layout :enable_layout

  protected

 def session_debug
   return unless Rails.env.development?
   logger.debug("SESSION"+session.inspect)
 end

  def json_request?
    request.format.json?
  end

  private
  def enable_layout
    agent_signed_in? ? 'management' : 'portal'
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
