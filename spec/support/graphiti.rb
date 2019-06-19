# frozen_string_literal: true

require 'graphiti_spec_helpers/rspec'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include GraphitiSpecHelpers::RSpec
  config.include GraphitiSpecHelpers::Sugar

  # Raise errors during tests by default
  config.before :each do
    #GraphitiErrors.disable!
  end

  # Clean your DB between test runs
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  ensure
    DatabaseCleaner.clean
  end
end
