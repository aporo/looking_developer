require 'spec_helper'

describe "repositories/index.html.erb" do
  before(:each) do
    assign(:repositories, [
      stub_model(Repository,
        :url => "Url"
      ),
      stub_model(Repository,
        :url => "Url"
      )
    ])
  end

  it "renders a list of repositories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
