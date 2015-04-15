class MembersController < ApplicationController
  # XXX これフィルタのままでいい？アクションに入れた方がいい？
  before_action :redirect_to_top, unless: :signed_in? , only: %(index)

  def index
    @members = Member.all
  end

  private

  def redirect_to_top
    redirect_to signin_path
  end
end
