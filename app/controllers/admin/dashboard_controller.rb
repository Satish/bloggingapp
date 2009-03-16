class Admin::DashboardController < Admin::BaseController
  
  def index
    @posts = Post.all
    @comments = Comment.all
  end
  
end
