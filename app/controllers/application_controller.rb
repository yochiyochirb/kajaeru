class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :signed_in?

  private

  def current_user
    case controller_name
    when 'votes', 'members'
      # Voter を入れる
      Voter.find_by(member_id: session[:user_id]) if session[:user_id]
      #Member.find(session[:user_id]) if session[:user_id]
    #when '結果'
      # Candidate を入れる
    end
  end

  def signed_in?
    !!current_user
  end
end
