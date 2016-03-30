require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  test 'vote by current_user' do
    ApplicationController.stub_any_instance(:current_user, voters(:alice_voter)) do
      post votes_url, params: { vote: { candidate_id: candidates(:bob_candidate).id, comment: 'thank you' } }
      assert_equal voters(:alice_voter), Vote.last.voter
    end
  end

  test 'create action should require current user to be voter' do
    ApplicationController.stub_any_instance(:current_user, members(:doe)) do
      assert_no_difference('Vote.count') do
        post votes_url, params: { vote: { candidate_id: roles(:bob_candidate).id, comment: '' } }
        assert_redirected_to root_url
        assert assert_equal '投票する権限がありません', flash[:alert]
      end
    end
  end
end
