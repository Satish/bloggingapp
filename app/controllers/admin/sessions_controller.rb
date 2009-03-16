# This controller handles the login/logout function of the site.  
class Admin::SessionsController < ApplicationController
  
  before_filter :login_required, :only => [:destroy]
  layout 'login'
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  skip_before_filter :verify_authenticity_token, :only => :create
  
  # render new.rhtml
  def new; end
  
  def create
    logout_keeping_session!
    if using_open_id?
      open_id_authentication
    else
      password_authentication
    end
  end
  
  def open_id_authentication
    authenticate_with_open_id(params[:openid_url], :required => [:nickname, :email]) do |result, identity_url|
      if result.successful? && self.current_user = User.find_by_identity_url(identity_url)
        successful_login
      else
        flash[:error] = result.message || "Sorry no user with that identity URL exists"
        @rememer_me = params[:remember_me]
        render :action => :new
      end
    end
  end
 
  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out successfully."
    redirect_back_or_default(admin_login_path)
  end

  protected ##################################
  
  def password_authentication
    user = User.authenticate(params[:login], params[:password])
    if user
      self.current_user = user
      successful_login
    else
      note_failed_signin
      @login = params[:login]
      @remember_me = params[:remember_me]
      render :action => :new
    end
  end
  
  def successful_login
    # It's possible to use OpenID only, in which
    # case the following would update a user's email and nickname
    # on login. 
    #
    # This may give conflicts when used in combination with regular
    # user accounts.
    #
    # TODO: Add a configuration option to disable regular accounts.
    #
    # current_user.update_attributes(
    #   :login => "#{params[:openid.sreg.nickname]}",
    #   :email => "#{params[:openid.sreg.email]}"
    # )
    new_cookie_flag = (params[:remember_me] == "1")
    handle_remember_cookie! new_cookie_flag
    redirect_back_or_default(admin_root_path)
    flash[:notice] = "You have been Logged in successfully"
  end
  
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
  
end
