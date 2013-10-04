# == Schema Information
#
# Table name: site_feedbacks
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  email      :string(255)
#  phone      :string(255)
#  message    :text
#  remote_ip  :string(255)
#  user_agent :string(255)
#  site_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class SiteFeedback < ActiveRecord::Base
  belongs_to :site

  validates_presence_of :referer
  validates_presence_of :remote_ip
  validates_presence_of :message
  validates_presence_of :username

  scope :newest, order(created_at: :desc)

end
