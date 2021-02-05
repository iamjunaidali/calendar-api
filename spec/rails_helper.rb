# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'database_cleaner'
require 'helper'
require 'support/factory_bot'
require 'database_cleaner'
require 'shoulda/matchers'
require 'faker'

# Add additional requires below this line. Rails is not loaded until this point!
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Helper

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.before do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :truncation
    DatabaseCleaner.start
  ensure
    DatabaseCleaner.clean
  end

  config.before do
    Sidekiq::Worker.clear_all
  end

  RSpec::Sidekiq.configure do |configuration|
    configuration.warn_when_jobs_not_processed_by_sidekiq = false
    configuration.clear_all_enqueued_jobs = true # default => true

    # Whether to use terminal colours when outputting messages
    configuration.enable_terminal_colours = true # default => true

    # Warn when jobs are not enqueued to Redis but to a job array
    configuration.warn_when_jobs_not_processed_by_sidekiq = true # default => true
  end

  Shoulda::Matchers.configure do |configuration|
    configuration.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  RSpec::Matchers.define :permit do |action|
    match do |policy|
      policy.public_send("#{action}?")
    end

    failure_message do |policy|
      "#{policy.class} does not permit #{action} on #{policy.record} for #{policy.user.inspect}."
    end

    failure_message_for_should_not do |policy|
      "#{policy.class} does not forbid #{action} on #{policy.record} for #{policy.user.inspect}."
    end
  end
end
