class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :enable_layout

  private
  def enable_layout
    user_signed_in? ? 'management' : 'portal'
  end

  def after_sign_in_path_for(resource)
    logger.debug("RESOURCE #{resource.inspect}")
    resource.kind_of?(User) ? management_index_path : root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    logger.debug("RESOURCE #{resource_or_scope.inspect}")
    root_path
  end
end
