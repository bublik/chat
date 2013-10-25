class LocationsController < ApplicationController

  # POST /locations
  # POST /locations.json
  def create
    Location.find_or_create_by(remote_ip: request.remote_ip, user_usid: params[:user_usid])
    send_data(Base64.decode64("R0lGODlhAQABAPAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="), :type => "image/gif", :disposition => "inline")
  end

end
