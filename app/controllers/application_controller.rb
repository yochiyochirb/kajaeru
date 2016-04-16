class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :signed_in?
  before_action :require_to_signin

  rescue_from Pundit::NotAuthorizedError, with: :render_404

  def render_404(exeption = nil)
    if exeption
      render file: File.join(Rails.root, 'public', '404.html'), status: 404
    end
  end

  private

  def current_user
    Member.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def require_to_signin
    redirect_to signin_path, alert: 'サインインしてください。' unless signed_in?
  end
end
