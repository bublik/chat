require "spec_helper"

describe SiteFeedbacksController do
  describe "routing" do

    it "routes to #index" do
      get("/site_feedbacks").should route_to("site_feedbacks#index")
    end

    it "routes to #new" do
      get("/site_feedbacks/new").should route_to("site_feedbacks#new")
    end

    it "routes to #show" do
      get("/site_feedbacks/1").should route_to("site_feedbacks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/site_feedbacks/1/edit").should route_to("site_feedbacks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/site_feedbacks").should route_to("site_feedbacks#create")
    end

    it "routes to #update" do
      put("/site_feedbacks/1").should route_to("site_feedbacks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/site_feedbacks/1").should route_to("site_feedbacks#destroy", :id => "1")
    end

  end
end
