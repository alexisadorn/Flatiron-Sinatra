require 'spec_helper'

describe 'app.rb' do
  describe 'GET /goodbye/:name' do
    it 'sends a 200 status code' do
      get '/goodbye/danny'
      expect(last_response.status).to eq(200)
    end

    it "displays 'goodbye' and a name" do
      get '/goodbye/danny'
      expect(last_response.body).to include("Goodbye, danny.")
    end

    it "is not hard-coded" do
      get '/goodbye/fannie'
      expect(last_response.body).to include("Goodbye, fannie.")
    end
  end

  describe 'GET /multiply/:num1/:num2' do
    it 'sends a 200 status code' do
      get '/multiply/5/5'
      expect(last_response.status).to eq(200)
    end

    it 'displays the product of the two numbers in the route' do
      get '/multiply/6/6'
      expect(last_response.body).to include("36")
    end

    it 'is not hard-coded' do
      get '/multiply/7/7'
      expect(last_response.body).to include("49")
      expect(last_response.body).to_not include("36")
    end
  end
end