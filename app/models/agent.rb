# == Schema Information
#
# Table name: agents
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)      default("")
#  avatar                 :string(255)
#  plan_id                :integer          default(5)
#

class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable, # :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sites
  has_many :subscriptions
  has_one :subscription, -> { order('created_at') }, class_name: 'Subscription'

  belongs_to :plan
  # Jabber Authorization User
  has_many :users
  delegate :username, to: :user

  mount_uploader :avatar, AvatarUploader #  thumb, small

  validates_integrity_of :avatar
  validates_processing_of :avatar
  validate :plan_exists

  paginates_per 10

  before_create do |agent|
    agent.users << User.build_user(agent.email)
  end

  # has_many
  def archive_collections
    ArchiveCollection.newest.where(with_user: jabber_names)
  end

  def full_name
    name.blank? ? short_name : name
  end

  def short_name
    email.split('@').first
  end

  def selected_user
    User.for_site(self.id)
  end

  def jabber_names
    self.users.pluck(:username)
  end

  def widget_json
    operator = selected_user
    {
        name: operator.operator_name || operator.username,
        email: (Rails.env.development? ? 'admin@helperchat.com' : operator.jabber_account),
        avatar_path: avatar.thumb.url,
        status: operator.get_state
    }
  end

  # Statictics
  def total_collections
    archive_collections.count
  end
  # count per day collections for last m months
  def last_months_collections(m)
    # fill empty dates with zeros
    zeros = {}
    (Date.today - m.month..Date.today).to_a.map { |date| zeros[date] = 0 }
    data = archive_collections.last_months(m).per_day.count
    zeros.merge(data).to_a
  end


  def users_last_months_collections(m)
    if users.empty?
      return last_months_collections(m)
    end
    data = (Date.today - m.month..Date.today).to_a.insert(0, 'Date').map{|i| [i]}
    users.each do |user|
      data[0] << user.username
      user_data = user.last_months_collections(m)
      # data << user_data
      (1...data.length).each do |i|
        data[i] << user_data[i-1][1]
      end
    end
    data
  end

  def total_messages
    ArchiveMessage.joins(:archive_collection).where('archive_collections.with_user IN (?)', jabber_names).count
  end

  # total chatting time in seconds
  def total_chating_time
    archive_collections.select("sum(TIME_TO_SEC(TIMEDIFF(change_utc, utc))) as utc").first['utc'].to_i
  end

  def admin?
    role.eql?('admin')
  end

  protected
  def plan_exists
    Plan.where('plans.id = ?', self.plan_id).exists?
  end


end
