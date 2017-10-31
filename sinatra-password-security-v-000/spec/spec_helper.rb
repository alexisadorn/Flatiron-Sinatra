ENV["SINATRA_ENV"] = "test"
require_relative '../config/environment.rb'
require 'rack/test'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
  config.order = 'default'
end

def session
  last_request.env['rack.session']
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app