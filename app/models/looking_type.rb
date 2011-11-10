class LookingType < ActiveRecord::Base
  validates_presence_of :user_id, :type_id
  belongs_to :user
  belongs_to :type
end
