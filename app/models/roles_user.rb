class RolesUser < ActiveRecord::Base
  
  validates_presence_of :role_id, :user_id
  validates_uniqueness_of :role_id, :scope => :user_id
  
  belongs_to :role
  belongs_to :user
  
end
