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
#

class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,# :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :site
  # Jabber Authorization User
  has_one :user

  def full_name
    name.blank? ? short_name : name
  end

  def short_name
    email.split('@').first
  end

  def avatar_path
    '/assets/noname.jpeg'
  end

end
