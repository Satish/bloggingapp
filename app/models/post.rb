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
  acts_as_paranoid
  
  has_permalink :title, :permalink
  attr_protected :status, :active
  
  named_scope :active, :conditions => { :active => true }
  named_scope :inactive, :conditions => { :active=> false }
  
  validates_presence_of :title, :permalink, :description
  validates_uniqueness_of :title, :permalink
  
  has_many :comments,  :as => :commentable, :dependent => :destroy
  has_many :tags
  
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  
  def self.search(search, page)
    paginate :per_page => 5, :page => page,
             :conditions => ['title like ? or description like ?', "%#{search}%", "%#{search}%"], :order => 'title'
  end
  
  def tag_list
    
  end
  
  def url
    created_at.strftime("/%Y/%m/%d/") + permalink
  end
  
  class << self
    def find_by_date_and_permalink(year, month, day, permalink, options={})
      begin
        post = Post.find_by_permalink(permalink, options)
        post && post.created_at.to_date == Date.new(year.to_i, month.to_i, day.to_i) ? post : nil
      rescue # Invalid time
        nil
      end
    end
    
  end
  
end
