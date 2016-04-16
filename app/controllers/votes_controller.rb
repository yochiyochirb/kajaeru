class VotesController < ApplicationController
  include EventSetter

  before_action :require_votable_event,  except: :total
  before_action :set_voter
  before_action :require_not_voted_yet,  only: %i(new create)
  before_action :set_candidates,         only: %i(new create edit)
  before_action :set_vote,               only: %i(show edit update)

  def show
  end

  def new
    @vote = @voter.build_vote
  end

  def create
    @vote = @voter.build_vote(vote_params)

    if @vote.save
      redirect_to event_vote_path(@event, @vote)
    else
      render :new
    end
  end

  def update
    @vote.update!(vote_params)
    redirect_to event_vote_path(@event, @vote)
  end

  def total
    @vote_results = Vote.total(event: @event)
  end

  private

  def require_votable_event
    authorize @event, :votable?
  end

  def set_voter
    @voter = current_user.as_voter_for(@event)
  end

  def require_not_voted_yet
    redirect_to event_path(@event),
                alert: 'すでにこのイベントには投票済みです' if @voter.voted_for?(@event)
  end

  def set_candidates
    @candidates = Candidate.for_this_event(@event)
                           .where.not(member_id: current_user.id)
  end

  def set_vote
    @vote = policy_scope(Vote.find(params[:id]))
  end

  def vote_params
    params.require(:vote).permit(:candidate_id, :comment)
  end
end
