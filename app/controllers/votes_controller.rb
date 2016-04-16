class VotesController < ApplicationController
  before_action :set_event
  before_action :set_voter
  before_action :require_to_be_voter,    except: :total
  before_action :check_if_already_voted, only: %i(new create)
  before_action :require_empty_vote,     only: %i(new)
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

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_candidates
    @candidates = Candidate.for_this_event(@event)
                           .where.not(member_id: current_user.id)
  end

  def set_voter
    @voter = current_user.as_voter_for(@event)
  end

  def set_vote
    @vote = policy_scope(Vote.find(params[:id]))
  end

  def require_to_be_voter
    redirect_to event_path(@event),
                alert: '投票する権限がありません' unless @voter
  end

  def require_empty_vote
    redirect_to edit_vote_path(current_user.voter.vote),
                alert: 'あなたは既に投票済みです。' if @voter.vote
  end

  def vote_params
    params.require(:vote).permit(:candidate_id, :comment)
  end

  def check_if_already_voted
    redirect_to event_path(@event),
                alert: 'すでにこのイベントには投票済みです' if @voter.voted_for?(@event)
  end
end
