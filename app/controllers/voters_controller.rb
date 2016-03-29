class VotersController < ApplicationController
  include RolesCommonConcerns

  def index
    @voters = @event.candidates.all
  end
end
