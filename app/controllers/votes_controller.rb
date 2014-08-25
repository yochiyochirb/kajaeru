class VotesController < ApplicationController
  before_action :set_vote, only: :show
  before_action :set_members, only: %i(new edit)
  before_action :redirect_root_with_alert, unless: :current_user_voting?, only: :show

  def new
    @vote = Vote.new
  end

  def show
    @member = Member.find(@vote.voted_member_id)
  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def update
    @vote = Vote.find(params[:id])

    if @vote.update_attributes(vote_params)
      redirect_to @vote, notice: '投票を更新しました。'
    else
      set_members
      render :edit
    end
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.voting_member_id = session[:user_id]
    if @vote.save
      redirect_to @vote, notice: 'ありがとうございます。投票を受け付けました。'
    else
      set_members
      render :new
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:voted_member_id, :comment)
  end

  def set_members
    @members = Member.all
  end

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def current_user_voting?
    @vote.voting_member_id == current_user.id
  end

  def redirect_root_with_alert
    redirect_to root_path, alert: '他の方の投票を見る事はできません'
  end
end
