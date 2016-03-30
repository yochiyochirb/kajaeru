require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  setup do
    @alice = members(:alice)
    @doe = members(:doe)
  end

  test 'voter? should return true when member has voters' do
    assert @alice.voter?
  end

  test 'voter? should return false when member does not have voters' do
    refute @doe.voter?
  end

  test 'as_voter should return voter associated to the member' do
    assert_equal roles(:alice_voter), @alice.as_voter
  end

  test 'as_voter should return nil with no voter associated to the member' do
    assert_nil @doe.as_voter
  end
end
