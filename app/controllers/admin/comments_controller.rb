class Admin::CommentsController < Admin::BaseController
  
  before_filter :find_comment, :only => [:show, :edit, :update, :destroy]
  before_filter :owner_required, :only => [:edit, :update, :destroy]
  
  def index
    @comments = Comment.search(params[:search], :page => params[:page], :per_page => 1)
    respond_to do |format|
      format.html{}
      format.xml{ render :xml => @comments }
    end
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(params[:comment])
    if current_user.comments << @comment
      respond_to do |format|
        format.html do
          flash[:message] = 'Comment Created successfully.'
          redirect_to [:admin, @comment] and return
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
    if @comment.update_attributes(params[:comment])
      respond_to do |format|
        format.html do
          flash[:message] = 'Comment updated successfully.'
          redirect_to [:admin, @comment] and return
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
          if @comment.destroy
            page.remove("comment_#{@comment.id}")
          else
            page.alert(BAD_REQUEST_ERROR_MESSAGE)
          end
        end
      end
      format.html do
        flash[:message] = 'Comment deleted successfully.' if @comment.destroy
        redirect_to_comments_home and return
      end
    end
  end
  
  private #######################
  
  def find_comment
    @comment = Comment.find_by_id(params[:id])
    redirect_to_comments_home and return unless @comment
  end
  
  def redirect_to_comments_home
    redirect_to [:admin, Comment.new] and return
  end
  
  def owner_required
    redirect_to_comments_home and return unless current_user.has_ownership?(@comment)
  end
  
end
