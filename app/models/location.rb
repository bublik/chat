# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  user_usid  :string(255)
#  remote_ip  :string(255)
#  address    :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime
#  updated_at :datetime
#  platform   :string(255)      default("")
#  version    :string(255)      default("")
#  browser    :string(255)      default("")
#

class Location < ActiveRecord::Base
  geocoded_by :remote_ip
  reverse_geocoded_by :latitude, :longitude

  #Validation
  validates_presence_of :user_usid
  after_validation :geocode, :reverse_geocode, :if => :remote_ip_changed?

end
