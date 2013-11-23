require 'spec_helper'

describe Api::UsersController do
  let(:agent) { FactoryGirl.create(:agent) }
  let(:user) { FactoryGirl.create(:user, :online, agent: agent) }
  let(:authorize) {
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(APP_CONFIG['api']['base_user'], APP_CONFIG['api']['base_password']) }

  describe "GET 'online'" do
    it "returns http success" do
      authorize
      post 'online', user: user.username
      response.body.should be_blank
      response.status.should eq(200)
    end
  end

  describe "GET 'offline'" do
    it "returns http success" do
      authorize
      post 'offline', user: user.username
      response.body.should be_blank
      response.status.should eq(200)
    end
  end

  describe "GET 'state'" do
    it "returns http success" do
      get 'state', user: user.username
      response.should be_success
    end
  end

end
