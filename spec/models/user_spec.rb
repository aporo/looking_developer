# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  def valid_attributes
    {:name => 'John Smith', :email => 'john@gmail.com',:pass => "john"}
  end

  def invalid_attributes(empty_key='name')
    if empty_key == 'name'
      {:name => '', :email => 'john@gmail.com', :pass => 'john'}
    elsif empty_key == 'email'
      {:name => 'John Smith', :email => '', :pass => 'john'}
    else
      {:name => 'John Smith', :email => 'john', :pass => ''}
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
        @john = User.create(valid_attributes)
        @john_clone = User.create(valid_attributes)
        @john_miss_name = User.new(invalid_attributes('name'))
        @john_miss_email = User.new(invalid_attributes('email'))
        @john_miss_pass = User.new(invalid_attributes)
      end
      
      it "name is unique" do
        @john.should be_valid
        @john_clone.should_not be_valid
      end
      it { @john_miss_name.should_not be_valid }
      it { @john_miss_email.should_not be_valid }
      it { @john_miss_pass.should_not be_valid }
    end
  end

  describe 'looking' do
    before do
      @john = User.create(valid_attributes)
      @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
      @php = Type.create(:name => 'PHP', :pattern => '.php')
      @java = Type.create(:name => 'Java', :pattern => '.java')
      LookingType.create(:user_id => @john.id,:type_id => @ruby.id)
      LookingType.create(:user_id => @john.id,:type_id => @php.id)
    end
    
    it "john's looking is [Ruby,PHP]" do
        @john.looking.should be_a_kind_of(Array)
      @john.looking[0].should == @ruby.name
      @john.looking[1].should == @php.name
      @john.looking.include?(@java.name).should be_false
    end
  end

  describe 'not_looking' do
    before do
      @john = User.create(valid_attributes)
      @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
      @php = Type.create(:name => 'PHP', :pattern => '.php')
      @java = Type.create(:name => 'Java', :pattern => '.java')
      LookingType.create(:user_id => @john.id,:type_id => @ruby.id)
      LookingType.create(:user_id => @john.id,:type_id => @php.id)
    end
    
    it "john's looking is empty" do
      @john.not_looking.should be_a_kind_of(Array)
      @john.not_looking[0].should == @java
    end
  end
  
  describe 'commit_count' do
    before do
      @john = User.create(valid_attributes)
      @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
      @commit_log = CommitLog.create(:user_id => @john.id, :type_id => @ruby.id,:commit_at => Time.now, :count => 1)
    end
    
    it "john's commit_count == 1" do
      @john.commit_count.should == 1
    end
  end

  describe 'owner?(user_id)' do
    before do
      @john = User.create(valid_attributes)
    end
    
    it { @john.owner?(@john.id).should be_true }
    it { @john.owner?(12345).should be_false }
  end

  describe 'self.auth?' do
    before do
      @john = User.create(valid_attributes)
    end
    it { User.auth?(:name => "John Smith", :pass => "john").should be_true }
    it { User.auth?(:name => "John Smith", :pass => "bob").should be_false }
  end
  
  describe 'encode' do
    before do
      @john = User.create(valid_attributes)
    end
    
    it { @john.pass.should == @john.encode(valid_attributes[:pass])}
  end
  
  describe 'has_twitter?' do
    context "do not have twitter" do
      before do
        @john = User.create(valid_attributes)
      end
      
      it { @john.has_twitter?.should be_false }
    end
    context "have twitter" do
      before do
        @bob = User.create({:name => "bob", :email => "bob@gmail.com", :pass => "bob", :twitter => "bob"})
      end
      
      it { @bob.has_twitter?.should be_true }
    end
  end


  describe 'after_destroy' do
    before do
      @john = User.create(valid_attributes)
      @bob = User.create({:name => "bob", :email => "bob@gmail.com", :pass => "bob", :twitter => "bob"})
      @ruby = Type.create({:name => "ruby", :pattern => ".rb"})
      LookingType.create({:user_id => @john.id, :type_id => @ruby.id})
      LookingType.create({:user_id => @bob.id, :type_id => @ruby.id})
      CommitLog.create({:user_id => @john.id, :type_id => @ruby.id, :commit_at => Time.now})
      CommitLog.create({:user_id => @bob.id, :type_id => @ruby.id, :commit_at => Time.now})
      @john.destroy
      @bob.reload
    end
    
    it "delete johns's looking_type" do
      LookingType.find_by_user_id(@john.id).should be_nil
    end

    it "do not delete johns's looking_type" do
      @bob.looking_types.should_not be_empty
    end

    it "delete john's commit_log" do
      CommitLog.find_by_user_id(@john.id).should be_nil
    end

    it "do not delete bob's commit_log" do
      @bob.commit_logs.should_not be_empty
    end
  end
end
