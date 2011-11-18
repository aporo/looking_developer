class LookingType < ActiveRecord::Base
  validates_presence_of :user_id, :type_id
  validates_uniqueness_of :user_id, :scope => [:type_id]
  belongs_to :user
  belongs_to :type

  def self.rank
    type_count = Type.all.map do |type|
      count = LookingType.count(:conditions => {:type_id => type.id})
      {:name => type.name,:count => count,:id => type.id}
    end
    type_count.sort{|a,b| b[:count] <=> a[:count]}
  end
end
