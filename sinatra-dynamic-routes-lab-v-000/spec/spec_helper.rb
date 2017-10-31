ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rack/test'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods

  config.order = 'default'
end

def app
  Rack::Builder.parse_file('config.ru').first
end