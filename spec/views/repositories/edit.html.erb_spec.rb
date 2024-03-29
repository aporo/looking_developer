require 'spec_helper'

describe "repositories/edit.html.erb" do
  before(:each) do
    @repository = assign(:repository, stub_model(Repository,
      :url => "MyString"
    ))
  end

  it "renders the edit repository form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => repositories_path(@repository), :method => "post" do
      assert_select "input#repository_url", :name => "repository[url]"
    end
  end
end
