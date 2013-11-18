class User < ActiveRecord::Base
  belongs_to :agent

  validates_format_of :username, with: /\A([a-z0-9\-_\+]+)\z/i, on: :create
  validates_uniqueness_of :username
  validates_presence_of :username
  validates_presence_of :password
  validates_associated :agent

  def jabber_account
    "#{username}@#{APP_CONFIG['HOST']}"
  end
end
