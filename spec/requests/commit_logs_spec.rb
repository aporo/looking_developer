require 'spec_helper'

describe "CommitLogs" do
  describe "GET /commit_logs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get commit_logs_path
      response.status.should be(200)
    end
  end
end
