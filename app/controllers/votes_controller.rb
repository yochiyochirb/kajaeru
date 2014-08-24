class VotesController < ApplicationController
  # TODO: ログインしていないときは見れないようにしたい

  def new
    # 投票されるメンバーを取得
    @members = Member.all

  end

  def show
  end

  def edit
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
  end

  private

  def vote_params
    params.require(:member).permit(:comment, :voted_member_id)
  end
end
