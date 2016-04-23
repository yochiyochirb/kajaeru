require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  setup do
    @alice = members(:alice)
  end

  test 'as_voter_for returns voter associated to event' do
    assert_equal voters(:alice_voter),
                 @alice.as_voter_for(events(:senbatsu_election))
  end

  test 'as_voter_for returns nil when without voter for event' do
    assert_equal nil,
                 @alice.as_voter_for(events(:us_presidential_election))
  end
end
