require 'spec_helper'

describe 'App' do
  
  describe "GET '/'" do
    before do
      get '/'
    end
    
    it "returns a 200 status code" do
      expect(last_response.status).to eq(200)
    end


    it "renders index.erb" do
      expect(last_response.body).to eq(File.read("views/index.erb"))
    end


    it "displays the name of the bowling alley in an h1 tag" do
      expect(last_response.body).to include("<h1> Buster's Best Bowling Alley</h1>")
    end

    it "displays the bowling alley tagline in an h2" do
      expect(last_response.body).to include("<h2> Bet You Can't Bowl A Strike Every Time</h2>")
    end

    it "displays the bowling alley address in a p tag" do
      expect(last_response.body).to include("<p> 97 Bowling Alley Lane, Boulder CO </p>")
    end

  end

end