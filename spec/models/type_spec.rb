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
      before do
        @ruby = Type.create(valid_attributes)
        @ruby_clone = Type.create(valid_attributes)
      end

      it "name is unique" do
        @ruby.should be_valid
        @ruby_clone.should_not be_valid
      end
      
      it { Type.new(invalid_attributes).should_not be_valid }
      it { Type.new(invalid_attributes("pattern")).should_not be_valid }
    end
  end

  describe 'rank' do
    before do
      @john  = User.create(:name => "John", :email => "john@gmail.com", :pass => "john")
      @bob   = User.create(:name => "Bob", :email => "bob@gmail.com", :pass => "bob")
      @alice = User.create(:name => "Alice", :email => "alice@gmail.com", :pass => "alice")
      @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
      users = User.all
      types = Type.all
      CommitLog.create(:user_id => @john.id, :type_id => @ruby.id, :commit_at => Time.now,:count => 3)
      CommitLog.create(:user_id => @alice.id, :type_id => @ruby.id, :commit_at => Time.now, :count => 2)
      CommitLog.create(:user_id => @bob.id, :type_id => @ruby.id, :commit_at => Time.now, :count => 1)
      @ruby.reload
    end

    it { @ruby.rank.should be_a_kind_of(Array) }
    it { @ruby.rank[0][:name].should == @john.name }
    it { @ruby.rank[1][:name].should == @alice.name }
    it { @ruby.rank[2][:name].should == @bob.name }
  end

  describe 'self.rank' do
    before do
      @john  = User.create(:name => "John", :email => "john@gmail.com", :pass => "john")
      @bob   = User.create(:name => "Bob", :email => "bob@gmail.com", :pass => "bob")
      @alice = User.create(:name => "Alice", :email => "alice@gmail.com", :pass => "alice")
      @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
      @php = Type.create(:name => 'PHP', :pattern => '.php')
      @java = Type.create(:name => 'Java', :pattern => '.java')
      @js = Type.create(:name => 'JavaScript', :pattern => '.js')
      users = User.all
      types = Type.all
      CommitLog.create(:user_id => @john.id, :type_id => @ruby.id, :commit_at => Time.now, :count => 3)
      CommitLog.create(:user_id => @john.id, :type_id => @php.id, :commit_at => Time.now, :count => 2)
      CommitLog.create(:user_id => @bob.id, :type_id => @js.id, :commit_at => Time.now, :count => 1)
    end

    it { Type.rank.should be_a_kind_of(Array) }
    it { Type.rank[0][:name].should == @ruby.name }
    it { Type.rank[1][:name].should == @php.name }
    it { Type.rank[2][:name].should == @js.name }
  end

  describe 'after_destroy' do
    before do
      @john  = User.create(:name => "John", :email => "john@gmail.com", :pass => "john")
      @ruby = Type.create({:name => "ruby", :pattern => ".rb"})
      @php = Type.create({:name => "php", :pattern => ".php"})
      LookingType.create({:user_id => @john.id, :type_id => @ruby.id})
      LookingType.create({:user_id => @john.id, :type_id => @php.id})
      CommitLog.create({:user_id => @john.id, :type_id => @ruby.id, :commit_at => Time.now})
      CommitLog.create({:user_id => @john.id, :type_id => @php.id, :commit_at => Time.now})
      @ruby.destroy
      @john.reload
    end
    
    it "delete johns's looking_type only ruby" do
      @john.looking_types.size.should == 1
      @john.looking_types[0].type.should == @php
      LookingType.count(:conditions => {:user_id => @john.id}).should == 1
    end

    it "delete john's commit_log only ruby" do
      @john.commit_logs.size.should == 1
      @john.commit_logs[0].type.should == @php
      CommitLog.count(:conditions => {:user_id => @john.id}).should == 1
    end
  end
end
