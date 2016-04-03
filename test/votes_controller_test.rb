require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  test 'vote by current_user' do
    ApplicationController.stub_any_instance(:current_user, voters(:alice_voter)) do
      post votes_url, params: { vote: { candidate_id: candidates(:bob_candidate).id, comment: 'thank you' } }
      assert_equal voters(:alice_voter), Vote.last.voter
    end
  end
end
