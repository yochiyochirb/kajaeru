class VotersController < ApplicationController
  include RolesCommonConcerns

  def index
    @voters = Voter.all
  end
end
