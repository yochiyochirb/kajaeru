ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Setting for minitest-reporters
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

class ActiveSupport::TestCase
  fixtures :all
end
