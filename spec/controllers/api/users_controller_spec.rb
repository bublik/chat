require 'spec_helper'

describe Api::UsersController do

  describe "GET 'online'" do
    it "returns http success" do
      get 'online'
      response.should be_success
    end
  end

  describe "GET 'offline'" do
    it "returns http success" do
      get 'offline'
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
