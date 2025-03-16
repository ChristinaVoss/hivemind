# frozen_string_literal: true

require 'capybara/rspec'

# Suppress specific Selenium deprecation warnings
Selenium::WebDriver.logger.ignore(:clear_session_storage)
Selenium::WebDriver.logger.ignore(:clear_local_storage)

Capybara.configure do |config|
  config.server = :puma, { Silent: true }
  config.always_include_port = true
  # This is where the server will listen.  We use this same `server_host` when
  # making requests in our browser etc.
  config.server_host = ENV.fetch('HOSTNAME', 'localhost')
  config.server_port = 7900
  config.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"

  # config.default_driver = :remote_selenium_headless
  config.javascript_driver = :remote_selenium_headless
end

# This is the URL of the Selenium server.  We use this to connect to the server
# and run our tests. (Not used until you dockerize your app, or possibly in github actions)
REMOTE_SELENIUM_URL = "http://#{ENV.fetch('SELENIUM_HOST', 'selenium')}:#{ENV.fetch('SELENIUM_PORT', '4444')}/wd/hub".freeze

CAPYBARA_DEVICE_RESOLUTIONS = {
  phone: [360, 740], # Samsung Galaxy S8, portrait
  tablet: [768, 1024], # iPad mini, portrait
  laptop: [1366, 768], # Standard 720p, landscape
  desktop: [1920, 1080] # Standard 1080p, landscape
}.freeze

# Use with `device: :phone, orientation: :portrait` in your test metadata and
# the browser will get resized to the correct size.
#
# Defaults to the last key in the list (desktop).
def set_capybara_screen_resolution(device: nil, orientation: nil)
  device ||= CAPYBARA_DEVICE_RESOLUTIONS.keys.last
  # This will blow up if the device isn't in the list.
  resolution = CAPYBARA_DEVICE_RESOLUTIONS.fetch(device)

  # Set up the orientation.
  case orientation
  when :portrait
    resolution.sort!
  when :landscape
    resolution.sort!.reverse!
  end

  Capybara.page.current_window.resize_to(*resolution)
end

Capybara.register_driver :remote_selenium do |app|
  if ENV['SELENIUM_HOST']
    Capybara::Selenium::Driver.new(app, browser: :firefox, url: REMOTE_SELENIUM_URL)
  else
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  end
end

Capybara.register_driver :remote_selenium_headless do |app|
  options = Selenium::WebDriver::Firefox::Options.new

  options.add_argument('--headless') if ENV['SHOW_BROWSER'] == 'false'

  if ENV['SELENIUM_HOST'] # If we're using a remote Selenium server (docker or github actions)
    puts "Using remote selenium at #{REMOTE_SELENIUM_URL}"
    Capybara::Selenium::Driver.new(app, browser: :firefox, url: REMOTE_SELENIUM_URL, options:)
  else
    Capybara::Selenium::Driver.new(app, browser: :firefox, options:)
  end
end
