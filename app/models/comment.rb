class Comment < ActiveRecord::Base
  belongs_to :commentable
end
