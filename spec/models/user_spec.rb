require 'spec_helper'

describe User do
  let(:agent) { FactoryGirl.create(:agent) }

  describe '.create' do
    it 'should create new user' do
      User.create!(username: 'test_agent', password: 'password', agent: agent)
      User.find_by_username('test_agent').should_not be_blank
    end

    it 'should not create two user with the same name' do
      attr = {username: 'test_agent', password: 'password', agent: agent}
      User.create!(attr)
      expect { User.create!(attr) }.to raise_error
    end
  end

  describe 'User status' do
    describe 'online' do
      let(:user) { FactoryGirl.create(:user, agent: agent) }

      it 'should be offline on default' do
        user.online?.should be_false
      end

      it 'should be string state' do
        user.get_state.should eq('offline')
      end

      it 'should mark user as Online' do
        User.mark_online(user.username)
        user.reload
        user.online?.should be_true
      end
    end

    describe 'offline' do
      let(:user) { FactoryGirl.create(:user, :online, agent: agent) }

      it 'should be string state' do
        user.get_state.should eq('online')
      end

      it 'should be offline on default' do
        user.online?.should be_true
      end

      it 'should mark user as Online' do
        User.mark_offline(user.username)
        user.reload
        user.online?.should be_false
      end
    end

    describe '#get_state' do
      let(:user) { FactoryGirl.create(:user, :online, agent: agent) }

      it 'should return *online* string' do
        User.get_state(user.username).should eq('online')
      end

      it 'should return *unknown_user* when unknow user' do
        User.get_state('asdasdasd').should eq('unknown_user')
      end
    end
  end
end
