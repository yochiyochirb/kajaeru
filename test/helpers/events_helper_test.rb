require 'test_helper'

class EventsHelperTest < ActionView::TestCase
  include EventsHelper

  test 'voting_period should return pretty string for starts_at and ends_at' do
    assert_equal '2000-01-01 00:00:00 〜 3000-01-01 00:00:00',
                 voting_period(events(:mad_tea_party_represent))
  end
end
