class CandidatesController < ApplicationController
  include RolesCommonConcerns

  def index
    @candidates = @event.candidates.all
  end
end
