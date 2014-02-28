class User < ActiveRecord::Base
  belongs_to :agent

  validates_format_of :username, with: /\A([a-z0-9\-\+]+)\z/i, on: :create
  validates_uniqueness_of :username
  validates_presence_of :username
  validates_presence_of :password
  validates_associated :agent

  scope :priority, lambda { order('users.state DESC , users.position ASC') }

  after_create do |user|
    Notification.jabber_user_created(agent, user)
  end

  def self.build_user(email = '')
    username = email.split('@').first.gsub('.','-') + Time.now.strftime("%H%M%S")
    User.new(username: username, password: SecureRandom.base64.slice(0..7))
  end

  # this method will return USERNAME for next operator or nil
  def self.for_site(agent_id)
    User.find_by_sql("SELECT * FROM
          (SELECT users.*, archive_collections.change_utc
          FROM archive_collections RIGHT JOIN users ON archive_collections.with_user = users.username
          WHERE users.agent_id = #{agent_id} AND users.enabled = true
          ORDER BY archive_collections.change_utc DESC) as users
    GROUP by username
    ORDER BY state DESC, change_utc ASC, position ASC").first

    #self.joins('LEFT OUTER JOIN archive_collections ON users.username = archive_collections.with_user')
    #.where('users.enabled = ? AND users.agent_id = ?', true, agent_id).group(:username)
    #.order('state DESC, archive_collections.change_utc DESC, position ASC').first

#    self.connection.execute("
#SELECT users.username  FROM users
#LEFT OUTER JOIN archive_collections
#ON users.username = archive_collections.with_user
#WHERE users.agent_id = #{agent_id}
#GROUP BY users.username
#ORDER BY state DESC, archive_collections.change_utc ASC, position ASC limit 1").first
  end

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

  def archive_collections
    ArchiveCollection.newest.where(with_user: username)
  end

  def last_months_collections(m)
    # fill empty dates with zeros
    zeros = {}
    (Date.today - m.month..Date.today).to_a.map { |date| zeros[date] = 0 }
    data = archive_collections.last_months(m).per_day.count
    zeros.merge(data).to_a
  end

end
