# == Schema Information
#
# Table name: users
#
#  username   :string(250)      not null, primary key
#  password   :text             not null
#  created_at :timestamp        not null
#  agent_id   :integer          not null
#

class User < ActiveRecord::Base
  belongs_to :agent

  validates_format_of :username, with: /\A([a-z0-9\.\-_\+]+)\z/i, on: :create
  validates_uniqueness_of :username
  validates_presence_of :username
  validates_presence_of :password
  validates_associated :agent

  def jabber_account
    "#{username}@#{APP_CONFIG['JABBER_HOST']}"
  end
end
