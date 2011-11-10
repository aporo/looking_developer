require 'spec_helper'

describe LookingType do
  def valid_attributes
    {:user_id => 1, :type_id => 1}
  end

  def invalid_attributes(empty_key='user_id') 
    if empty_key == 'user_id'
      {:user_id => '', :type_id => 1}
    else
      {:user_id => 1, :type_id => ''}
    end
  end
  describe 'validate' do
    context 'valid' do
      it { LookingType.new(valid_attributes).should be_valid }
    end

    context 'invalid' do
      it { LookingType.new(invalid_attributes).should_not be_valid }
      it { LookingType.new(invalid_attributes("type_id")).should_not be_valid }
    end
  end
end
