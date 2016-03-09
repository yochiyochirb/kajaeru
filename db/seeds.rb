# add seed data of members
# TODO FactoryGirl 使うようになったら、これぜんぶ factory にして、
#      FactoryGirl.create(:member)
#      みたいにインスタンスを作るコードが書いてある rake タスクを作りたいなー。
require 'active_record/fixtures'

if Rails.env.development?
  # Create records from fixtures
  fixtures_folder = File.join(Rails.root, 'features', 'fixtures')

  fixtures = Dir[File.join(fixtures_folder, '*.yml')].map do |f|
    File.basename(f, '.yml')
  end

  ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, fixtures)
end
