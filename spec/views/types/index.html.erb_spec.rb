require 'spec_helper'

describe "types/index.html.erb" do
  before(:each) do
    assign(:types, [
      stub_model(Type,
        :name => "Name",
        :pattern => "Pattern"
      ),
      stub_model(Type,
        :name => "Name",
        :pattern => "Pattern"
      )
    ])
  end

  it "renders a list of types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Pattern".to_s, :count => 2
  end
end
