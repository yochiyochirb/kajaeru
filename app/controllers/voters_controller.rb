class VotersController < ApplicationController
  include EventSetter

  def index
    @voters = @event.voters.all
  end
end
