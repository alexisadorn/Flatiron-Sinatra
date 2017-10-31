
require 'pry'
describe "Basic Routes Lab" do
  describe "GET '/name'" do
    before(:each) do
      get '/name'
    end

    it "returns a 200 status code" do
      expect(last_response.status).to eq(200)
    end

    it "displays your name" do
      expect(last_response.body).to include("My name is ")
    end
  end

  describe "GET '/hometown'" do
    before(:each) do
      get '/hometown'
    end

    it "returns a 200 status code" do
      expect(last_response.status).to eq(200)
    end

    it "displays your hometown" do
      expect(last_response.body).to include("My hometown is ")
    end

  end

  describe "GET '/favorite-song'" do
    before(:each) do
      get '/favorite-song'
    end

    it "returns a 200 status code" do
      expect(last_response.status).to eq(200)
    end

    it "displays your favorite song" do
      expect(last_response.body).to include("My favorite song is ")
    end

  
  end
end