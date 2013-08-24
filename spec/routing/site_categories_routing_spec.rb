require "spec_helper"

describe SiteCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/site_categories").should route_to("site_categories#index")
    end

    it "routes to #new" do
      get("/site_categories/new").should route_to("site_categories#new")
    end

    it "routes to #show" do
      get("/site_categories/1").should route_to("site_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/site_categories/1/edit").should route_to("site_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/site_categories").should route_to("site_categories#create")
    end

    it "routes to #update" do
      put("/site_categories/1").should route_to("site_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/site_categories/1").should route_to("site_categories#destroy", :id => "1")
    end

  end
end
