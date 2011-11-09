require 'spec_helper'

describe "looking_types/show.html.erb" do
  before(:each) do
    @looking_type = assign(:looking_type, stub_model(LookingType,
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
