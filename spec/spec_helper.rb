ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'selenium-webdriver'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

include OmniauthMacros
OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include ActiveSupport::Testing::TimeHelpers
end

def silence_omniauth
  previous_logger = OmniAuth.config.logger
  OmniAuth.config.logger = Logger.new("/dev/null")
  yield
ensure
  OmniAuth.config.logger = previous_logger
end
