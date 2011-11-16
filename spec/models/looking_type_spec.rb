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

  describe 'rank' do
    before do
      @john  = User.create(:name => "John", :email => "john@gmail.com", :pass => "john")
      @bob   = User.create(:name => "Bob", :email => "bob@gmail.com", :pass => "bob")
      @alice = User.create(:name => "Alice", :email => "alice@gmail.com", :pass => "alice")
      @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
      @php = Type.create(:name => 'PHP', :pattern => '.php')
      @java = Type.create(:name => 'Java', :pattern => '.java')
      @js = Type.create(:name => 'JavaScript', :pattern => '.js')
      LookingType.create(:user_id => @john.id,:type_id => @ruby.id)
      LookingType.create(:user_id => @bob.id,:type_id => @ruby.id)
      LookingType.create(:user_id => @alice.id,:type_id => @ruby.id)
      LookingType.create(:user_id => @john.id,:type_id => @php.id)
      LookingType.create(:user_id => @bob.id,:type_id => @php.id)
      LookingType.create(:user_id => @john.id,:type_id => @js.id)
      @rank = LookingType.rank
    end
    
    it { @rank.should be_a_kind_of(Array) }
    it { @rank[0].should == {:name => @ruby.name,:count => 3, :id => @ruby.id} }
    it { @rank[1].should == {:name => @php.name,:count => 2, :id => @php.id} }
    it { @rank[2].should == {:name => @js.name,:count => 1, :id => @js.id} }
  end
end
