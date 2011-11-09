require 'spec_helper'

describe "commit_logs/show.html.erb" do
  before(:each) do
    @commit_log = assign(:commit_log, stub_model(CommitLog,
      :user_id => 1,
      :type_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
