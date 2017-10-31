describe App do

  describe 'GET /hello' do
    before do
      get '/hello'
    end

    it 'sends a 200 status code' do
      expect(last_response.status).to eq(200)
    end

    it 'renders a template called "hello.erb" ' do
      expect(last_response.body).to eq(File.read("views/hello.erb"))
    end
  end

  describe 'GET /goodbye' do
    before do
      get '/goodbye'
    end

    it 'sends a 200 status code' do
      expect(last_response.status).to eq(200)
    end

    it 'renders a template called "goodbye.erb" ' do
      expect(last_response.body).to include("Goodbye Joe")
    end
  end
  describe 'GET /date' do
    before do
      get '/date'
    end

    it 'sends a 200 status code' do
      expect(last_response.status).to eq(200)
    end

    it 'renders a template called "date.erb" ' do
      expect(last_response.body).to include("The date is")
    end

    it 'includes the current date and time' do
      if last_response.status == 200
        expect(last_response.body).to include(Date.today.strftime("%A, %B %d, %Y"))
      elsif last_response.status = 404
        fail "Your application is not responding to GET /date. Did you create that route?"
      end
    end
  end
end

