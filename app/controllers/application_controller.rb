class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def current_user
    # let's use memoization.
    # without memoization, we'll need to query the db every time to find a user
    # but if we already referenced a current user and have current user object available, then
    # we can return a current user
    # Otherwise, we'll need to query the db to find a user.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    ## or !!current_user
    true if current_user
  end

  helper_method :current_user
  helper_method :logged_in?

end
