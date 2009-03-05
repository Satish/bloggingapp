# == Schema Information
#
# Table name: pages
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  permalink   :string(255)
#  description :text
#  status      :boolean(1)      default(TRUE)
#  active      :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

class Page < ActiveRecord::Base
  
  has_permalink :title, :permalink
  
  attr_protected :status, :active
  
  named_scope :active, :conditions => { :active => true }
  named_scope :inactive, :conditions => { :active=> false }
  
  validates_presence_of :title, :permalink, :description
  validates_uniqueness_of :title, :permalink
  
end
