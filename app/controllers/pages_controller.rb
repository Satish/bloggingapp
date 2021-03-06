class PagesController < ApplicationController
  
  before_filter :find_page, :only => [:show]

  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @meta_title = @page.title

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  private ###########################

  def find_page
    @page = Page.active.find_by_permalink(params[:permalink])
    redirect_to root_path and flash[:error] = PAGE_NOT_FOUND_ERROR_MESSAGE and return unless @page
  end

end
