require 'spec_helper'

describe "looking_types/index.html.erb" do
  before(:each) do
    assign(:looking_types, [
      stub_model(LookingType,
        :user_id => 1,
        :type_id => 11
      ),
      stub_model(LookingType,
        :user_id => 1,
        :type_id => 11
      )
    ])
  end

  it "renders a list of looking_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 11.to_s, :count => 2
  end
end
