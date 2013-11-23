class User < ActiveRecord::Base
  belongs_to :agent

  validates_format_of :username, with: /\A([a-z0-9\-_\+]+)\z/i, on: :create
  validates_uniqueness_of :username
  validates_presence_of :username
  validates_presence_of :password
  validates_associated :agent

  def online?
    state
  end

  def get_state
    state ? 'online' : 'offline'
  end

  def jabber_account
    "#{username}@#{APP_CONFIG['HOST']}"
  end

  def self.mark_online(username = '')
    where(username: username).update_all(state: true)
  end

  def self.mark_offline(username = '')
    where(username: username).update_all(state: false)
  end

  def self.get_state(username = '')
    where(username: username).first.get_state rescue 'unknown_user'
  end

end
