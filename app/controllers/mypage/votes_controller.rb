class Mypage::VotesController < ApplicationController
  before_action :redirect_to_top, unless: :signed_in?, only: :index

  def index
    @events = Event.all
    @my_votes = Vote.by_member(current_user).includes(:candidate)
  end

  private

  def redirect_to_top
    redirect_to signin_path
  end
end
