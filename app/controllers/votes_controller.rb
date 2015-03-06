class VotesController < ApplicationController
  before_action :set_members, only: %i(new edit)

  def new
    @vote = Vote.new
  end

  def create
    candidate = Candidate.find_by(member_id: vote_params[:candidate_id])
    current_user.do_vote(candidate)

    @vote = Vote.new(vote_params)
    redirect_to @vote
  end

  def show
    @vote = Vote.find(params[:id])
  end

  private

  # 自分がいま投票した相手
  def candidate
    Member.candidate
  end

  def set_members
    @members = Member.all
  end

  private

  def vote_params
    params.require(:vote).permit(:candidate_id, :comment)
  end
end
