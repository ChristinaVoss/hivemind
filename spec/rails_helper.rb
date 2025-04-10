# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
# Uncomment the line below in case you have `--require rails_helper` in the `.rspec` file
# that will avoid rails generators crashing because migrations haven't been run yet
# return unless Rails.env.test?
require 'rspec/rails'
require 'capybara/rspec'
# Add additional requires below this line. Rails is not loaded until this point!
# Add additional requires below this line. Rails is not loaded until this point!
Rails.root.glob('spec/support/**/*.rb').each { |f| require f }

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails uses metadata to mix in different behaviours to your tests,
  # for example enabling you to call `get` and `post` in request specs. e.g.:
  #
  #     RSpec.describe UsersController, type: :request do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/7-1/rspec-rails
  #
  # You can also this infer these behaviours automatically by location, e.g.
  # /spec/models would pull in the same behaviour as `type: :model` but this
  # behaviour is considered legacy and will be removed in a future version.
  #
  # To enable this behaviour uncomment the line below.
  # config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  #
  # config.include WaitForAjax, type: :system
  config.include AuthenticationHelpers, type: :system
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers, type: :component
  config.include PreviewPathHelper, type: :system
  config.include ViewComponent::TestHelpers, type: :component
  config.include Rails.application.routes.url_helpers, type: :component

  # To be able to use validate_presence_of() matchers with Rspec:
  Shoulda::Matchers.configure do |c|
    c.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  # Configure system tests.
  config.before(type: :system) do |example|
    # When we don't need JS (or a specific device), use rack test for speed.
    unless example.metadata[:js] || example.metadata[:device]
      driven_by :rack_test
      next
    end

    # We need to allow net connect at this stage to allow WebDrivers to update
    # or Capybara to talk to selenium etc.
    WebMock.allow_net_connect!

    # Ensure we update the driver here, while we can connect to the network
    # Webdrivers::Chromedriver.update

    if ENV['SHOW_BROWSER'] == 'true'
      driven_by :remote_selenium
    else
      driven_by :remote_selenium_headless
    end

    # Need to set the hostname, otherwise it defaults to www.example.com.
    default_url_options[:host] = Capybara.server_host

    WebMock.disable_net_connect!(allow_localhost: true, allow: [ENV.fetch('SELENIUM_HOST', 'selenium'), Capybara.server_host])

    set_capybara_screen_resolution(**example.metadata.slice(:device, :orientation))
  end
end
