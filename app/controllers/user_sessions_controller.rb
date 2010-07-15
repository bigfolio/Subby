class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = @current_account.user_sessions.build(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to users_path
    else
      render :action => 'new'
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_back_or_default login_url
  end

end
