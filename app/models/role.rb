# == Schema Information
#
# Table name: roles
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  blog_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :roles_users, :dependent => :destroy, :conditions => {:active => true}
  has_many :users, :through => :roles_users
  
end
