require 'test_helper'

class VoterTest < ActiveSupport::TestCase
  setup do
    @alice_voter = voters(:alice_voter)
    @bob_candidate = candidates(:bob_candidate)
  end

  test 'voted_for? returns true if voter has already voted for event' do
    refute @alice_voter.voted_for?(events(:senbatsu_election))
    @alice_voter.create_vote(comment: 'iluvu', candidate_id: @bob_candidate.id)
    assert @alice_voter.voted_for?(events(:senbatsu_election))
  end
end
