require 'spec_helper'

describe "repositories/show.html.erb" do
  before(:each) do
    @repository = assign(:repository, stub_model(Repository,
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
  end
end
