require 'spec_helper'

describe "looking_types/edit.html.erb" do
  before(:each) do
    @looking_type = assign(:looking_type, stub_model(LookingType,
      :user_id => 1,
      :type_id => 1
    ))
  end

  it "renders the edit looking_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => looking_types_path(@looking_type), :method => "post" do
      assert_select "input#looking_type_user_id", :name => "looking_type[user_id]"
      assert_select "input#looking_type_type_id", :name => "looking_type[type_id]"
    end
  end
end
