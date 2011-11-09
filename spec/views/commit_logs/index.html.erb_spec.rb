require 'spec_helper'

describe "commit_logs/index.html.erb" do
  before(:each) do
    assign(:commit_logs, [
      stub_model(CommitLog,
        :user_id => 1,
        :type_id => 1
      ),
      stub_model(CommitLog,
        :user_id => 1,
        :type_id => 1
      )
    ])
  end

  it "renders a list of commit_logs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
