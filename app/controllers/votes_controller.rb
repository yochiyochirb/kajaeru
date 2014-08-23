class VotesController < ApplicationController
  def new
    # 投票されるメンバーを取得
    @members = Member.all
    @vote    = Vote.new
  end

  def show
  end

  def edit
    @members = Member.all
    @vote    = Vote.find(params[:id])
  end
  
  def update 
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
end
