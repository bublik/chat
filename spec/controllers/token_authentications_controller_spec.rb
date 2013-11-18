require 'spec_helper'

describe TokenAuthenticationsController do
  let(:agent) { FactoryGirl.create(:agent) }

  before do
    sign_in agent
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should redirect_to(edit_agent_registration_path)
      agent.reload
      agent.authentication_token.should_not be_blank
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should redirect_to(edit_agent_registration_path)
      agent.reload
      agent.authentication_token.should be_blank
    end
  end

end
