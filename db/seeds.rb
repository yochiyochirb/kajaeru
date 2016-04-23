require 'active_record/fixtures'

if Rails.env.development?
  # Create records from fixtures
  fixtures_directory = File.join(Rails.root, 'test', 'fixtures')
  fixtures = Dir[File.join(fixtures_directory, '*.yml')].map do |f|
    File.basename(f, '.yml')
  end
  ActiveRecord::FixtureSet.create_fixtures(fixtures_directory, fixtures)
end
