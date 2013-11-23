require 'spec_helper'

describe Api::UsersController do
  let(:agent) { FactoryGirl.create(:agent) }
  let(:user) { FactoryGirl.create(:user, :online, agent: agent) }

  describe "GET 'online'" do
    it "returns http success" do
      post 'online'
      response.should be_success
    end
  end

  describe "GET 'offline'" do
    it "returns http success" do
      post 'offline'
      response.should be_success
    end
  end

  describe "GET 'state'" do
    it "returns http success" do
      get 'state'
      response.should be_success
    end
  end

end
