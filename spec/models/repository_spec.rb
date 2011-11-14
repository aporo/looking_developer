require 'spec_helper'

describe Repository do
  describe 'validate' do
    context 'valid' do
      it { Repository.new(:url => "hoge.com").should be_valid }
    end

    context 'invalid' do
      it { Repository.new(:url => "").should_not be_valid }
    end
  end
end
