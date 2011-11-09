class CommitLog < ActiveRecord::Base
  validates_presence_of :commit_at,:user_id
end
