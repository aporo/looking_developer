class Type < ActiveRecord::Base
  validates_presence_of :name,:pattern
  has_many :looking_types

  def self.rank
    type_count = Type.all.map do |type|
      count = CommitLog.count(:conditions => {:type_id => type.id})
      {:name => type.name,:count => count, :id => type.id}
    end
    type_count.sort{|a,b| b[:count] <=> a[:count]}
  end
end
