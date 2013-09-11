class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,# :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sites
  # Jabber Authorization User
  has_one :user

  def full_name
    name.blank? ? (email.blank? ? 'You' : email) : name
  end

  def avatar_path
    '/assets/noname.jpeg'
  end

end
