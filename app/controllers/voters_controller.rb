class VotersController < ApplicationController
  include EventSetter

  def index
    @voters = @event.candidates.all
  end
end
