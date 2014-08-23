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
    vote = Vote.new(permit_param)
    vote.voting_member_id = session[:user_id]
    begin
      vote.save!
      redirect_to action:'show', id:vote.id
    rescue => e
      puts e.message
      redirect_to action:'new'
    end
  end

  private

  def permit_param
    param = params.require(:vote).permit(:voted_member_id, :comment)
  end
end
