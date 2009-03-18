class Admin::BaseController < ApplicationController
  
  include AuthenticatedSystem
  include RoleRequirementSystem
  
  before_filter :login_required
  before_filter :find_blog
  layout 'admin'

  uses_tiny_mce(:options => AppConfig.advanced_mce_options, :only => [:new, :edit, :create, :update])
  
  def redirect_to_admin_root_path
    redirect_to admin_root_path and return
  end
  
  def find_blog
    @blog = Blog.first
  end
  
end
