require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test 'bootstrap_alert_class should return class corresponded to flash type' do
    assert_equal 'alert-info', bootstrap_alert_class('notice')
    assert_equal 'alert-danger', bootstrap_alert_class('alert')
    assert_empty bootstrap_alert_class('non_existent_key')
  end
end
