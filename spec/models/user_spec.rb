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
        @john_miss_name = User.new(invalid_attributes('name'))
        @john_miss_email = User.new(invalid_attributes('email'))
        @john_miss_pass = User.new(invalid_attributes)
      end
      
      it { @john_miss_name.should_not be_valid }
      it { @john_miss_email.should_not be_valid }
      it { @john_miss_pass.should_not be_valid }
    end
  end

  describe 'looking' do
    context 'Lookしているtypeの場合' do
      before do
        @john = User.create(valid_attributes)
        @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
        @php = Type.create(:name => 'PHP', :pattern => '.php')
        LookingType.create(:user_id => @john.id,:type_id => @ruby.id)
        LookingType.create(:user_id => @john.id,:type_id => @php.id)
      end

      it "john's looking is [Ruby,PHP]" do
        @john.looking.should be_a_kind_of(Array)
        @john.looking[0].should == @ruby.name
        @john.looking[1].should == @php.name
      end
    end
    context 'Lookしていないtypeの場合' do
      before do
        @john = User.create(valid_attributes)
        @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
        @php = Type.create(:name => 'PHP', :pattern => '.php')
      end

      it "john's looking is empty" do
        @john.looking.should be_a_kind_of(Array)
        @john.looking.should be_empty
      end
    end
  end

  describe 'not_looking' do
    context 'Lookしているtypeの場合' do
      before do
        @john = User.create(valid_attributes)
        @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
        @php = Type.create(:name => 'PHP', :pattern => '.php')
        LookingType.create(:user_id => @john.id,:type_id => @ruby.id)
        LookingType.create(:user_id => @john.id,:type_id => @php.id)
      end

      it "john's looking is empty" do
        @john.not_looking.should be_a_kind_of(Array)
        @john.not_looking.should be_empty
      end
    end
    context 'Lookしていないtypeの場合' do
      before do
        @john = User.create(valid_attributes)
        @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
        @php = Type.create(:name => 'PHP', :pattern => '.php')
      end

      it "john's looking is [Ruby,PHP]" do
        @john.not_looking.should be_a_kind_of(Array)
        @john.not_looking[0].should == @ruby
        @john.not_looking[1].should == @php
      end
    end
  end

  describe 'commit_count' do
    before do
      @john = User.create(valid_attributes)
      @ruby = Type.create(:name => 'Ruby', :pattern => '.rb')
      @commit_log = CommitLog.create(:user_id => @john.id, :type_id => @ruby.id,:commit_at => Time.now)
    end
    
    it "john's commit_count == 1" do
      @john.commit_count.should == 1
    end
  end

  describe 'self.owner?(user_id)' do
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
end
