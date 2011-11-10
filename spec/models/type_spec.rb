require 'spec_helper'

describe Type do
    def valid_attributes
    {:name => "Ruby",:pattern => ".rb"}
  end

  def invalid_attributes(empty_key='name') 
    if empty_key == 'name'
      {:name => "",:pattern => ".rb"}
    else
      {:name => "Ruby",:pattern => ""}
    end
  end
  describe 'validate' do
    context 'valid' do
      it { Type.new(valid_attributes).should be_valid }
    end
    
    context 'invalid' do
      it { Type.new(invalid_attributes).should_not be_valid }
      it { Type.new(invalid_attributes("pattern")).should_not be_valid }
    end
  end
end
