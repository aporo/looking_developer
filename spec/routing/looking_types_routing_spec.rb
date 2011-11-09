require "spec_helper"

describe LookingTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/looking_types").should route_to("looking_types#index")
    end

    it "routes to #new" do
      get("/looking_types/new").should route_to("looking_types#new")
    end

    it "routes to #show" do
      get("/looking_types/1").should route_to("looking_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/looking_types/1/edit").should route_to("looking_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/looking_types").should route_to("looking_types#create")
    end

    it "routes to #update" do
      put("/looking_types/1").should route_to("looking_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/looking_types/1").should route_to("looking_types#destroy", :id => "1")
    end

  end
end
