class Admin::BlogsController < Admin::BaseController
  
  layout 'admin'
  before_filter :find_blog
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:edit, :update])
  
  # GET /blogs/1/edit
  def edit; end

  # PUT /blogs/1
  # PUT /blogs/1.xml
  def update
    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        flash[:message] = 'Settings updated successfully.'
        format.html { redirect_to(edit_admin_blog_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  private ######################
  
  def find_blog
    @blog = Blog.first
  end
  
end
