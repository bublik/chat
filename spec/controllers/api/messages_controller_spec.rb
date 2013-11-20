require 'spec_helper'

describe Api::MessagesController do
  let(:agent) { FactoryGirl.create(:agent_with_user) }

  before do
    agent.reset_authentication_token!
    @token = agent.authentication_token
  end

  describe "#create with correct token" do
    before do
      stub_request(:post, "http://public.helperchat.com:5285/rest/").
          with(:body => "<message to='#{agent.user.jabber_account}' from='noreply@system/rest'><body>MESSAGE</body></message>",
               :headers => {'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'Content-Length' => '95', 'User-Agent' => 'Ruby'}).
          to_return(:status => 200, :body => "", :headers => {})
    end

    it "should be authorized by token" do
      post :create, {message: {body: 'MESSAGE'}, auth_token: @token, format: :json}
      response.status.should eq(201)
      assigns(:current_agent).should_not be_blank
    end

    it "should fail with incorrect token" do
      post :create, {message: {body: 'MESSAGE'}, auth_token: 'incorrect', format: :json}
      response.status.should eq(401)
      assigns(:current_agent).should be_blank
    end
  end

end
