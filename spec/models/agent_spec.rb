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
