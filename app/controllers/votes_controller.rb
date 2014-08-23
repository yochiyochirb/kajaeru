class VotesController < ApplicationController
  def new
    # 投票されるメンバーを取得
    @members = Member.all

  end

  def show
  end

  def edit
  end

  def update 
  end

  def create 

  private

  def vote_params
    params.require(:member).permit(:comment, :voted_member_id)
  end
end
