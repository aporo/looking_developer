class User < ActiveRecord::Base
  validates_presence_of :name,:email
  has_many :commit_logs
  has_many :looking_types

  def looking
    self.looking_types.map do |looking_type|
      unless looking_type.type.nil?
        looking_type.type.name
      end
    end
  end

  def not_looking
    Type.all.select do |type|
      self.looking_types.any?{ |looking_type| looking_type.type_id == type.id } == false
    end
  end
  
  def commit_count
    self.commit_logs.length
  end

  def commit_count_by_type
    Type.all.map do |type|
      {:name => type.name , :count => CommitLog.count(:conditions => {:user_id => self.id,:type_id => type.id})}
    end
  end
end
