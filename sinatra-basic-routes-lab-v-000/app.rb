require_relative 'config/environment'

class App < Sinatra::Base

  get '/' do
    "Hello, World!"
  end

  get '/name' do
    "My name is Alexis"
  end

  get '/hometown' do
    "My hometown is Lakewood"
  end

  get '/favorite-song' do
    "My favorite song is Castle of Glass"
  end
end
