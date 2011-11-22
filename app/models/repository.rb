class Repository < ActiveRecord::Base
  validates_presence_of :url
  validates_uniqueness_of :url
  
  def import
    User.import_repository_data(self)
    CommitLog.import_repository_data(self)
  end
end
