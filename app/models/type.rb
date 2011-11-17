class Type < ActiveRecord::Base
  validates_presence_of :name,:pattern
  has_many :looking_types
  has_many :commit_logs
  after_destroy :destroy_relation

  def rank
    users = User.all
    user_count = users.map do |user|
      count = CommitLog.count(:conditions => {:user_id => user.id, :type_id => self.id})
      {:name => user.name, :id => user.id, :count => count}
    end
    user_count.sort{|a,b| b[:count] <=> a[:count]}[0..4]
  end


  def self.rank
    type_count = Type.all.map do |type|
      count = CommitLog.count(:conditions => {:type_id => type.id})
      {:name => type.name,:count => count, :id => type.id}
    end
    type_count.sort{|a,b| b[:count] <=> a[:count]}[0..9]
  end

  private
  def destroy_relation
    self.looking_types.each do |look_type|
      look_type.delete
    end
    self.commit_logs.each do |commit|
      commit.delete
    end
  end
end
