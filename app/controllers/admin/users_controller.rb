class Admin::UsersController < Admin::BaseController
  
  require_role 'admin', :except => [:index, :edit, :update]
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:edit, :update, :suspend, :unsuspend, :destroy, :purge]
  
  def index
    @users = User.search(params[:search], :page => params[:page])
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      redirect_back_or_default(admin_users_path)
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def edit; end
    
  def update
    if @user.update_attributes(params[:user])
      flash[:message] = "#{@user.login}'s account updated successfully' "
      redirect_to [:edit, :admin, @user]
    else
      render :action => "edit"
    end
  end
  
  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to admin_login_path
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_to :back
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_to :back
    end
  end

  def suspend
    @user.suspend! 
    redirect_to [:admin, User.new]
  end
  
  def unsuspend
    @user.unsuspend! 
    redirect_to [:admin, User.new]
  end

  def destroy
    @user.delete!
    redirect_to [:admin, User.new]
  end

  def purge
    @user.destroy
    redirect_to [:admin, User.new]
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

  protected ##################################
  
  def find_user
    @user = current_user.has_role?('admin') ? User.find_by_id(params[:id]) : current_user
    redirect_to_admin_root_path and return unless @user
  end
  
end
