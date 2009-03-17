# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  author           :string(255)
#  author_url       :string(255)
#  author_email     :string(255)
#  description      :text
#  spam             :boolean(1)
#  active           :boolean(1)
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base
  
  attr_protected :active, :spam
  
  named_scope :active, :conditions => { :active => true, :spam => false }
  named_scope :inactive, :conditions => { :active=> false }
  
  validates_presence_of :author, :author_email, :description
  validates_uniqueness_of :description, :scope => [:author, :author_email]
  validates_format_of :author_email, :with => EMAIL_REG, :unless => Proc.new{|c| c.author_email.blank?}

  belongs_to :commentable  
  
  def activate!
    self.update_attribute(:active, true)
  end

  def self.search(query, options={})
    default_options = {:per_page => 5, :conditions => ['author like ? or description like ? or author_email like ? or author_url like ? ', "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"], :order => 'created_at DESC'}
    
    paginate default_options.merge(options)
  end

end
