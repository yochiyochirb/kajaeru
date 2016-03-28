require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  test 'vote by current_user' do
    ApplicationController.stub_any_instance(:current_user, voters(:alice_voter)) do
      post votes_url, params: { vote: { candidate_id: candidates(:bob_candidate).id, comment: 'thank you' } }
      assert_equal members(:bob), Vote.find_by(voter: voters(:alice_voter)).candidate.member
    end
  end
end
