class VotesController < ApplicationController
  before_action :set_candidates, only: %i(new edit)
  before_action :set_vote,       only: %i(show edit update)

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.create!(vote_params.merge(voter_id: current_user.id))
    redirect_to @vote
  end

  def update
    @vote.update!(vote_params)
    redirect_to @vote
  end

  def total
    @vote_results = Vote.total
  end

  private

  def set_candidates
    @candidates = Candidate.where.not(member_id: current_user.member.id)
  end

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:candidate_id, :comment)
  end
end
