# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  PAGE_NOT_FOUND_ERROR_MESSAGE = "Sorry, The page you were looking cannot be found..."
  BAD_REQUEST_ERROR_MESSAGE = "Sorry, We are unable to process your request..."

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  before_filter :find_blog

  def find_blog
    @blog = Blog.first
    unless @blog
      render :text => "qs qs  qs  q"
    else
      render :text => @blog.disable_message, :layout => false unless @blog.active?
    end
  end

  def set_meta_atttributes
#    @meta_title = @blog.meta_title unless @meta_title
#    @meta_description = @blog.meta_description
#    @meta_keywords = @blog.meta_keywords
  end
  
end
