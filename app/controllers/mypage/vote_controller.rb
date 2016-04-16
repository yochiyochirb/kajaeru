class Mypage::VoteController < ApplicationController
  before_action :redirect_to_top, unless: :signed_in?, only: :show

  def show
    @events = Event.all
    @my_votes = Vote.for_member(current_user).includes(:candidate)
  end

  private

  def redirect_to_top
    redirect_to signin_path
  end
end
