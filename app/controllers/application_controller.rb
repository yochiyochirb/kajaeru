class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :signed_in?

  private

  def current_user
    Member.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end
end
