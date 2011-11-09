require 'spec_helper'

describe "types/edit.html.erb" do
  before(:each) do
    @type = assign(:type, stub_model(Type,
      :name => "MyString",
      :pattern => "MyString"
    ))
  end

  it "renders the edit type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => types_path(@type), :method => "post" do
      assert_select "input#type_name", :name => "type[name]"
      assert_select "input#type_pattern", :name => "type[pattern]"
    end
  end
end
