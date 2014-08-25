class VotesController < ApplicationController
  before_action :set_members, only: %i(new edit)

  def new
    @vote = Vote.new
  end

  def show
  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def update
    @vote = Vote.find(params[:id])

    if @vote.update_attributes(vote_params)
      redirect_to @vote, notice: 'Vote was successfully updated.'
    else
      set_members
      render :edit
    end
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.voting_member_id = session[:user_id]
    if @vote.save
      redirect_to @vote, notice: 'Vote was successfully created.'
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
end
