class Admin::PostsController < Admin::BaseController
  
  before_filter :find_post, :only => [:show, :edit, :update, :destroy]
  before_filter :owner_required, :only => [:edit, :update, :destroy]
  
  def index
    options = {:page => params[:page]}
    @posts = params[:tag].blank? ? Post.search(params[:search], options) : Post.paginate_tagged_with(params[:tag], options)
    respond_to do |format|
      format.html{}
      format.xml{ render :xml => @posts }
    end
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    if current_user.posts << @post
      @post.publish! if params[:commit] == "Publish"
      respond_to do |format|
        format.html do
          flash[:message] = 'Post Created successfully.'
          redirect_to [:admin, @post] and return
        end
      end
    else
      respond_to do |format|
        format.html { render :action => 'new'}
      end
    end
  end
  
  def edit; end
  
  def update
    if @post.update_attributes(params[:post])
      respond_to do |format|
        format.html do
          flash[:message] = 'Post updated successfully.'
          redirect_to [:admin, @post] and return
        end
      end
    else
      respond_to do |format|
        format.html { render :action => 'edit'}
      end
    end
  end
  
  def destroy
    respond_to do |format|
      format.js do
        render :update do |page|
          if @post.destroy
            page.remove("post_#{@post.id}")
          else
            page.alert(BAD_REQUEST_ERROR_MESSAGE)
          end
        end
      end
      format.html do
        flash[:message] = 'Post deleted successfully.' if @post.destroy
        redirect_to_posts_home and return
      end
    end
  end
  
  private #######################
  
  def find_post
    @post = Post.find_by_id(params[:id])
    redirect_to_posts_home and return unless @post
  end
  
  def redirect_to_posts_home
    redirect_to [:admin, Post.new] and return
  end
  
  def owner_required
    redirect_to_posts_home and return unless current_user.has_ownership?(@post)
  end
    
end
