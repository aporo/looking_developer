require 'spec_helper'

describe "commit_logs/new.html.erb" do
  before(:each) do
    assign(:commit_log, stub_model(CommitLog,
      :user_id => 1,
      :type_id => 1
    ).as_new_record)
  end

  it "renders new commit_log form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => commit_logs_path, :method => "post" do
      assert_select "input#commit_log_user_id", :name => "commit_log[user_id]"
      assert_select "input#commit_log_type_id", :name => "commit_log[type_id]"
    end
  end
end
