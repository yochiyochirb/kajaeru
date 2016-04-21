class Mypage::VoteController < ApplicationController
  before_action :redirect_to_top, unless: :signed_in?, only: :show

  def show
    @my_vote = current_user.voter.vote
  end

  private

  def redirect_to_top
    redirect_to signin_path
  end
end
