require 'spec_helper'

describe CommitLog do
  def valid_attributes(user,type)
    {:commit_at => Time.now, :user_id => user.id,:type_id => type.id }
  end

  def invalid_attributes(empty_key='commit_at')
    if empty_key == 'commit_at'
      {:commit_at => '', :user_id => "1",:type_id => "1" }
    else
      {:commit_at => Time.now, :user_id => "",:type_id => "1" }
    end
  end


  describe 'validate' do
    context 'valid' do
      before do
        bob = User.create(:name => 'Bob', :email => 'bob@gmail.com', :pass => "bob")
        ruby = Type.create(:name => 'Ruby')
        @bob_log = CommitLog.new(valid_attributes(bob,ruby))
      end
      
      it { @bob_log.should be_valid }
    end
    
    context 'invalid' do
      before do
        bob = User.create(:name => 'Bob', :email => 'bob@gmail.com', :pass => "bob")
        ruby = Type.create(:name => 'Ruby')
        bob_log = valid_attributes(bob,ruby)
        @bob_log = CommitLog.create(bob_log)
        @bob_log_clone = CommitLog.create(bob_log)
        @commit_miss_time = CommitLog.new(invalid_attributes)
        @commit_miss_user = CommitLog.new(invalid_attributes('user'))
      end

      it "user_id,type_id,commit_at is unique" do
        @bob_log.should be_valid
        @bob_log_clone.should_not be_valid
      end
      
      it { @commit_miss_time.should_not be_valid }
      it { @commit_miss_user.should_not be_valid }
    end
  end
end
