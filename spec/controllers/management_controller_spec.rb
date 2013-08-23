require 'spec_helper'

describe ManagementController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'report'" do
    it "returns http success" do
      get 'report'
      response.should be_success
    end
  end

end
