require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test 'should get votes for_this_event' do
    actual = Vote.for_this_event(events(:senbatsu_election))
    expected = [
      votes(:alice_by_charlie),
      votes(:alice_by_john),
      votes(:john_by_doe)
    ]
    assert_equal expected.sort_by(&:id), actual.order(:id).records
  end

  test 'should get votes by_member' do
    actual = Vote.by_member(members(:doe))
    expected = [votes(:john_by_doe)]
    assert_equal expected.sort_by(&:id), actual.order(:id).records
  end

  test 'total should return reformatted array for votes' do
    actual = Vote.total(event: events(:senbatsu_election))
    @alice_candidate = candidates(:alice_candidate)
    @john_candidate = candidates(:john_candidate)
    expected = [
      {
        nickname: @alice_candidate.member.nickname,
        image: @alice_candidate.member.image,
        total: 2,
        comments: [votes(:alice_by_john).comment,
                   votes(:alice_by_charlie).comment]
      },
      {
        nickname: @john_candidate.member.nickname,
        image: @john_candidate.member.image,
        total: 1,
        comments: [votes(:john_by_doe).comment]
      }
    ]
    assert_equal expected, actual
  end
end
