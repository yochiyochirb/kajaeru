class CandidatesController < ApplicationController
  include RolesCommonConcerns

  def index
    @candidates = Candidate.all
  end
end
