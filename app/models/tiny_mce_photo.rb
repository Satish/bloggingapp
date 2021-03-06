# == Schema Information
#
# Table name: tiny_mce_photos
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  content_type :string(255)
#  filename     :string(255)
#  thumbnail    :string(255)
#  description  :text
#  user_id      :integer(4)
#  parent_id    :integer(4)
#  blog_id      :integer(4)
#  size         :integer(4)
#  width        :integer(4)
#  height       :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class TinyMcePhoto < ActiveRecord::Base

  has_attachment  :storage => :file_system,
                  :content_type => [:image, 'application/x-shockwave-flash'],
                  :max_size => 5.megabytes,
                  :resize_to => '600x>',
                  :thumbnails => {:thumb => "100>", :medium => "290x320>", :large => "664>",},
                  :processor => 'Rmagick',
                  :path_prefix => 'public/images/tiny_mce/photos'

  validates_as_attachment

  belongs_to :user
  
  def display_name
    self.name ? self.name : self.created_at.strftime("created on: %m/%d/%y")
  end
  
end
