require 'spec_helper'

describe Repository do
  describe 'validate' do
    context 'valid' do
      it { Repository.new(:url => "hoge.com").should be_valid }
    end

    context 'invalid' do
      before do
        @rails_repo = Repository.create(:url => "rails")
        @rails_repo_clone = Repository.create(:url => "rails")
      end

      it "url is unique" do
        @rails_repo.should be_valid
        @rails_repo_clone.should_not be_valid
      end
      it { Repository.new(:url => "").should_not be_valid }
    end
  end
end
