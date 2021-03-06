# == Schema Information
#
# Table name: pages
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  permalink   :string(255)
#  description :text
#  user_id     :integer(4)
#  blog_id     :integer(4)
#  active      :boolean(1)      default(TRUE)
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class Page < ActiveRecord::Base
  
  acts_as_paranoid
  
  has_permalink :title, :permalink
  
  attr_protected :status#, :active
  
  named_scope :active, :conditions => { :active => true }
  named_scope :inactive, :conditions => { :active=> false }
  
  validates_presence_of :title, :permalink, :description
  validates_uniqueness_of :title, :permalink
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  
  def self.search(search, page)
    paginate :per_page => 5, :page => page,
             :conditions => ['title like ? or description like ?', "%#{search}%", "%#{search}%"], :order => 'title'
  end

  def url
    permalink
  end

end
