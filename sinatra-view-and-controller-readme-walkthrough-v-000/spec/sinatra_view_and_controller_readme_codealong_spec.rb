require 'spec_helper'

describe "App" do
  describe 'POST /reverse' do
    it 'responds with a 200' do
      params = {
        :string => 'Super Silly String'
      }

      post '/reverse', params

      expect(last_response.status).to eq(200)
    end

    it 'displays the reversed string' do
      params = {
        :string => 'Super Silly String'
      }

      post '/reverse', params

      expect(last_response.body).to include(params[:string].reverse)
    end
  end

  describe 'GET /friends' do
    it 'responds with a 200' do
      get '/friends'

      expect(last_response.status).to eq(200)
    end

    it 'displays friends in the view' do
      @friends = ['Emily Wilding Davison', 'Harriet Tubman', 'Joan of Arc', 'Malala Yousafzai', 'Sojourner Truth']

      get '/friends'

      expect(last_response.body).to include('Malala Yousafzai')
    end
  end
end