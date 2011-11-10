class Type < ActiveRecord::Base
  validates_presence_of :name,:pattern
  has_many :looking_types
end
