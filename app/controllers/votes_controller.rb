class VotesController < ApplicationController
  before_action :set_member, only: %i(new edit update)

  def new
    @vote = Vote.new
  end

  def show
  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def update
    @vote = Vote.find_by!(id: params[:id], voting_member_id: current_user.id)

    if @vote.update_attributes(vote_params)
      flash[:notice] = '投票を更新しました。'
      redirect @vote
    else
      render :edit
    end
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.voting_member_id = session[:user_id]
    if @vote.save
      redirect_to @vote, notice: 'Vote was successfully created.'
    else
      @members = Member.all
      render :new
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:voted_member_id, :comment)
  end

  def set_member
    @members = Member.all
  end
end
