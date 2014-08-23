class MembersController < ApplicationController
  before_action :redirect_to_top, unless: :signed_in? , only: %(index)

  def index
  end

  private

  def redirect_to_top
    redirect_to signin_url
  end
end
