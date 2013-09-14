require 'spec_helper'

describe User do
  describe '.create' do
    it 'should create new user' do
      User.create!(username: 'test_agent', password: 'password', agent_id: 99)
      User.find_by_username('test_agent').should_not be_blank
    end

    it 'should not create two user with the same name' do
      attr = {username: 'test_agent', password: 'password', agent_id: 100}
      User.create!(attr)
      expect { User.create!(attr) }.to raise_error
    end
  end
end


