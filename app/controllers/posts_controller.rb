class PostsController < ApplicationController

  layout "application", :except => [:feed]
  before_filter :find_post, :only => [:show]
  after_filter :set_meta_atttributes
  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @meta_title = @post.title
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def feed
    @posts = Post.all
    respond_to do |format|
      format.rss  { render :rss => @posts }
    end
    
  end
  
#  # GET /posts/1
#  # GET /posts/1.xml
#  def sitemap
#    @post = @posts = Post.all(:select => "description, created_at, title")
#    respond_to do |format|
#      format.xml  { render :xml => @post, :layout => false }
#    end
#  end
  
  private ###########################

  def find_post
    @post = Post.published.find_by_date_and_permalink(*([:year, :month, :day, :permalink].collect {|x| params[x]} << {:include => [:comments]}))
    redirect_to root_path and flash[:error] = PAGE_NOT_FOUND_ERROR_MESSAGE and return unless @post
  end

end
