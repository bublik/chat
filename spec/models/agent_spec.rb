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

require 'spec_helper'

describe Agent do
  describe '#create' do
    it 'creates a record' do
      agent = Agent.find_or_initialize_by(email: 'admin@helperchat.com') do |agent|
        agent.password = 'changeme'
        agent.password_confirmation = 'changeme'
      end
      agent.save.should be_true
    end
  end
end
