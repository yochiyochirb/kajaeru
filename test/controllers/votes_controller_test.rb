require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alice = members(:alice)
    @vote_params = {
      event_id: events(:senbatsu_election).id,
      candidate_id: candidates(:bob_candidate).id,
      comment: 'thank you'
    }
  end

  test 'vote by current_user' do
    ApplicationController.stub_any_instance(:current_user, @alice) do
      post event_votes_url(event_id: events(:senbatsu_election).id),
           params: { vote: @vote_params }
      assert_equal voters(:alice_voter), Vote.last.voter
    end
  end

  test 'create action should require current user to have voting right for event' do
    ApplicationController.stub_any_instance(:current_user, @alice) do
      @alice.voters.each(&:destroy) # Remove voting permission from a member
      @alice.reload
      assert @alice.voters.empty?

      assert_no_difference('Vote.count') do
        post event_votes_url(event_id: events(:senbatsu_election).id),
             params: { vote: @vote_params }
        assert_response :not_found
      end
    end
  end
end
