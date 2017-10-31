describe 'App' do 

  describe 'GET /' do

    it 'returns a 200 status code' do 
      get '/'
      expect(last_response.status).to eq(200)
    end
    it 'loads the index.erb file' do 
      get '/'
      expect(last_response.body).to include("Hello World")
      expect(last_response.body).to include("This HTML code is inside of a '.erb' file")
    end
  end

  describe 'GET /info' do 
    it 'returns a 200 status code' do 
      get '/info'
      expect(last_response.status).to eq(200)
    end

    it 'loads info.erb in the view' do 
      get '/info'
      expect(last_response.body).to include("Info Page")
      expect(last_response.body).to include("This is the info page:")
    end
  end
end