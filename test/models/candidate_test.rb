require 'test_helper'

class CandidateTest < ActiveSupport::TestCase
  test 'should get candidates for_this_event' do
    actual = Candidate.for_this_event(events(:mad_tea_party_represent))
    expected = [
      candidates(:alice_candidate_for_mad_tea_party_represent),
      candidates(:mad_hatter_candidate),
      candidates(:dormouse_candidate)
    ]
    assert_equal expected.sort_by(&:id), actual.order(:id).records
  end
end
