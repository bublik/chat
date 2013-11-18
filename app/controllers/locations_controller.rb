class LocationsController < ApplicationController
  skip_before_filter :signup_master

  # POST /locations
  # POST /locations.json
  def create
    location = Location.find_or_create_by(user_usid: params[:user_usid])
    user_agent = UserAgent.parse(request.user_agent)
    location.update_attributes(remote_ip: request.remote_ip,
                               request_domain: (request.referrer.blank? ? '' : URI.parse(request.referrer).host),
                               platform: user_agent.platform,
                               browser: user_agent.browser)
    send_data(Base64.decode64("R0lGODlhAQABAPAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="), :type => "image/gif", :disposition => "inline")
  end

end
