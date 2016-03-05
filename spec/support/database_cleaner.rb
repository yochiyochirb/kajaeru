DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)

RSpec.configure do |config|
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
