class CandidatesController < ApplicationController
  include EventSetter

  def index
    @candidates = @event.candidates.all
  end
end
