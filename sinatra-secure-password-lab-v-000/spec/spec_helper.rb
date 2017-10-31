require_relative '../config/environment.rb'
require 'rack/test'
ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'capybara/rspec'
require 'capybara/dsl'
require 'rack_session_access/capybara'


if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

ApplicationController.configure do |app|
  app.use RackSessionAccess::Middleware
end

RSpec.configure do |config|

  config.include Rack::Test::Methods
  config.include Capybara::DSL


  config.order = 'default'
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app

# def session
#   last_request.env['rack.session']
# end