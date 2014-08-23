class VotesController < ApplicationController
  def new
  end

  def show
  end

  def edit
  end
  
  def update 
  end

  def create
    vote = Vote.new(vote_params)
    vote.voting_member_id = session[:user_id] 
    if vote.save
      redirect_to vote, notice: 'Vote was successfully created.'
    else
      render action: 'new'
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:voted_member_id, :comment)
  end
end
