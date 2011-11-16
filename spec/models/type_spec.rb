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

  describe 'rank' do
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
      10.times do 
        types.each do |type|
          users.each do |user|
            CommitLog.create(:user_id => user.id, :type_id => type.id, :commit_at => Time.now)
          end
        end
      end
      CommitLog.create(:user_id => @john.id, :type_id => @ruby.id, :commit_at => Time.now)
      CommitLog.create(:user_id => @alice.id, :type_id => @ruby.id, :commit_at => Time.now)
      CommitLog.create(:user_id => @bob.id, :type_id => @ruby.id, :commit_at => Time.now)
      CommitLog.create(:user_id => @john.id, :type_id => @php.id, :commit_at => Time.now)
      CommitLog.create(:user_id => @alice.id, :type_id => @php.id, :commit_at => Time.now)
      CommitLog.create(:user_id => @bob.id, :type_id => @js.id, :commit_at => Time.now)
    end

    it { Type.rank.should be_a_kind_of(Array) }
    it { Type.rank[0][:name].should == @ruby.name }
    it { Type.rank[1][:name].should == @php.name }
    it { Type.rank[2][:name].should == @js.name }
  end
end
