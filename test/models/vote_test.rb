require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  setup do
    @alice_voter = voters(:alice_voter)
    @bob_candidate = candidates(:bob_candidate)
    @muddy_candidate = candidates(:muddy_candidate)
  end

  test 'should fail when voter and candidate are not in the same event' do
    vote = @alice_voter.build_vote(comment: 'iluvu',
                                   candidate_id: @bob_candidate.id)
    assert vote.valid?

    vote = @alice_voter.build_vote(comment: 'iluvu',
                                   candidate_id: @muddy_candidate.id)
    refute vote.valid?
    assert 'cannot be voted because of candidate for different event',
           vote.errors.messages[:candidate_id]
  end
end
