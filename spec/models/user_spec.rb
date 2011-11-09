require 'spec_helper'

describe User do
  def valid_attributes
    {:name => 'John Smith', :email => 'john@gmail.com'}
  end

  def invalid_attributes(empty_key='name')
    if empty_key == 'name'
      {:name => '', :email => 'john@gmail.com'}
    else
      {:name => 'John Smith', :email => ''}
    end
  end


  describe 'validate' do
    context 'valid' do
      before do
        @john = User.new(valid_attributes)
      end
      
      it { @john.should be_valid }
    end

    context 'invalid' do
      before do
        @john_miss_name = User.new(invalid_attributes)
        @john_miss_email = User.new(invalid_attributes('email'))
      end
      
      it { @john_miss_name.should_not be_valid }
      it { @john_miss_email.should_not be_valid }
    end
  end
end
