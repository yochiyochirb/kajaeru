class MembersController < ApplicationController
  before_action :signed_in_user, unless: :signed_in? , only: %(index)

  def index
  end

  private

  def signed_in_user
    redirect_to signin_url
  end
end
