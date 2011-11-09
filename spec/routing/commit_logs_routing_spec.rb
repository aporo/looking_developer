require "spec_helper"

describe CommitLogsController do
  describe "routing" do

    it "routes to #index" do
      get("/commit_logs").should route_to("commit_logs#index")
    end

    it "routes to #new" do
      get("/commit_logs/new").should route_to("commit_logs#new")
    end

    it "routes to #show" do
      get("/commit_logs/1").should route_to("commit_logs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/commit_logs/1/edit").should route_to("commit_logs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/commit_logs").should route_to("commit_logs#create")
    end

    it "routes to #update" do
      put("/commit_logs/1").should route_to("commit_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/commit_logs/1").should route_to("commit_logs#destroy", :id => "1")
    end

  end
end
