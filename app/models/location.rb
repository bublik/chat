class Location < ActiveRecord::Base
  geocoded_by :remote_ip
  reverse_geocoded_by :latitude, :longitude

  #Validation
  validates_presence_of :user_usid
  validates_presence_of :remote_ip
  after_validation :geocode, :reverse_geocode, :if => :remote_ip_changed?

end
