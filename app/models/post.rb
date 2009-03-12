# == Schema Information
#
# Table name: posts
#
#  id           :integer(4)      not null, primary key
#  title        :string(255)
#  permalink    :string(255)
#  description  :text
#  status       :boolean(1)      default(TRUE)
#  active       :boolean(1)      default(TRUE)
#  published_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Post < ActiveRecord::Base

  acts_as_taggable
  
  has_permalink :title, :permalink
  
  attr_protected :status, :active
  
  named_scope :active, :conditions => { :active => true }
  named_scope :inactive, :conditions => { :active=> false }
  
  validates_presence_of :title, :permalink, :description
  validates_uniqueness_of :title, :permalink
  
  has_many :comments,  :as => :commentable, :dependent => :destroy
  has_many :tags
  
  def self.search(search, page)
    paginate :per_page => 5, :page => page,
             :conditions => ['title like ? or description like ?', "%#{search}%", "%#{search}%"], :order => 'title'
  end
  
  def tag_list
    
  end
  
end
