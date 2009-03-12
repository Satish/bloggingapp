# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  PAGE_NOT_FOUND_ERROR_MESSAGE = "Sorry, The page you were looking cannot be found..."
  BAD_REQUEST_ERROR_MESSAGE = "Sorry, We are unable to process your request..."

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
