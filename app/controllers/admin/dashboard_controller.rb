class Admin::DashboardController < Admin::AdminController
  
  def index
    @posts = Post.all
    @comments = Comment.all
  end
  
end
