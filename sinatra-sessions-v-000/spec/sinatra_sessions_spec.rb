require 'spec_helper'

describe 'App' do
  describe "GET '/'" do
    it "returns a 200 status code" do
      get '/'
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/first_exercise'" do
    it "returns a 200 status code" do
      get '/first_exercise'
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/set'" do
    it "sets session[:foo] equal to hello" do
      get '/set'
      expect(session[:foo]).to eq('hello')
    end
  end

  describe "GET '/fetch'" do
    it "returns a string specifying the correct session value" do
      get '/set'
      get '/fetch'
      expect(last_response.body).to include('session[:foo] value: hello.')
    end
  end

  describe "GET '/second_exercise'" do
    it "returns a 200 status code" do
      get '/second_exercise'
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET '/set_session'" do
    it "sets session[:id] equal to 1" do
      get '/set_session'
      expect(session[:id]).to eq(1)
    end
  end

  describe "GET '/fetch_session_id'" do
    it "returns a string specifying the correct session value" do
      get '/set_session'
      get '/fetch_session_id'
      expect(last_response.body).to include("session[:id] value: 1.")
    end
  end

  describe "GET '/logout'" do 
    it "clear the session hash" do 
      get '/logout'
      expect(last_response.body).to include("session content: {}")
    end
  end
end
