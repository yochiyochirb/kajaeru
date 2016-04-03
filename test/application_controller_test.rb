require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'members should sign in to use Kajaeru' do
    get new_vote_path

    assert_equal 'サインインしてください。', flash[:alert]
    assert_redirected_to signin_path
  end
end
