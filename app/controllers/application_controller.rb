class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  helper :all
  helper_method :current_user_session, :current_user
  
  before_filter :current_account
  
  private
    
    def current_account
      if request.subdomains.any? 
        @current_account ||= Account.find_by_subdomain(request.subdomains.first)
        @current_account ||= Account.find_by_domain(request.domain)
        raise ActiveRecord::RecordNotFound unless @current_account
      end
    end
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user && @current_account && current_user.account_id == @current_account.id
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end
    
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to '/'
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
  
end
