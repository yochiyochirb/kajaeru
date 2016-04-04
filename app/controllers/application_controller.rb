class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :signed_in?

  private

  def current_user
    Member.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end
end
