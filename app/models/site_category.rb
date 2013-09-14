# == Schema Information
#
# Table name: site_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class SiteCategory < ActiveRecord::Base
  has_many :sites

  validates_presence_of :name

end
