class VotesController < ApplicationController
  include EventSetter

  before_action :require_votable_event,     except: :total
  before_action :require_event_voting_in_session,  except: :total
  before_action :set_voter
  before_action :require_not_voted_yet,     only: %i(new create)
  before_action :set_candidates,            only: %i(new create edit)
  before_action :set_vote,                  only: %i(show edit update)
  before_action :require_correct_candidate, only: %i(create update)

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
    return redirect_to event_path(@event), alert: '集計結果はまだ公開されていません' unless @event.total_opened?

    @vote_results = Vote.total(event: @event)
  end

  private

  def require_votable_event
    authorize @event, :votable?
  end

  def require_event_voting_in_session
    redirect_to event_path(@event),
                alert: 'このイベントの投票期間ではありません' unless @event.voting_in_session?
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

  def require_correct_candidate
    unless Candidate.find(vote_params[:candidate_id]).in?(@event.candidates)
      redirect_to event_path(@event), alert: 'この候補者には投票できません'
    end
  end

  def vote_params
    params.require(:vote).permit(:candidate_id, :comment)
  end
end
