ENV["SINATRA_ENV"] = "test"
ENV["RACK_ENV"] = "test"

require_relative '../config/environment'

require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.order = 'default'
end

def app
  Rack::Builder.parse_file('config.ru').first
end
