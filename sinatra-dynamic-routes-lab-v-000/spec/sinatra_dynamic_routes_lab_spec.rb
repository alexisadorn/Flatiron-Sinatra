describe App do
  describe 'GET /reversename/:name' do
    it 'sends a 200 status code' do
      get '/reversename/victoria'

      expect(last_response.status).to eq(200)
    end

    it 'renders the name backwards' do
      get '/reversename/victoria'

      expect(last_response.body).to include('airotciv')
    end

    it "isn't hard-coded" do
      get '/reversename/joseph'

      expect(last_response.body).to include('hpesoj')
      expect(last_response.body).to_not include('airotciv')
    end
  end

  describe 'GET /square/:number' do
    it 'sends a 200 status code' do
      get '/square/4'

      expect(last_response.status).to eq(200)
    end

    it 'renders the square of the number' do
      get '/square/26'

      expect(last_response.body).to include('676')
    end

    it "isn't hard-coded" do
      get '/square/25'

      expect(last_response.body).to include('625')
      expect(last_response.body).to_not include('676')
    end
  end

  describe 'GET /say/:number/:phrase' do
    it 'sends a 200 status code' do
      get '/say/3/show%20me%20the%20money'

      expect(last_response.status).to eq(200)
    end

    it 'repeats the phrase n times' do
      get '/say/3/show%20me%20the%20money'

      expect(last_response.body.scan('show me the money').size).to eq(3)
    end

    it "isn't hard-coded" do
      get '/say/4/you%20had%20me%20at%20hello'

      expect(last_response.body.scan('you had me at hello').size).to eq(4)
      expect(last_response.body).to_not include('show me the money')
    end
  end

  describe 'GET /say/:word1/:word2/:word3/:word4/:word5' do
    it 'sends a 200 status code' do
      get '/say/stop/rhyming/I/mean/it'

      expect(last_response.status).to eq(200)
    end

    it 'concatenates the words and adds a period' do
      get '/say/stop/rhyming/I/mean/it'

      expect(last_response.body).to include('stop rhyming I mean it.')
    end

    it "isn't hard-coded" do
      get '/say/does/anybody/want/a/peanut'

      expect(last_response.body).to include('does anybody want a peanut.')
      expect(last_response.body).to_not include('stop rhyming I mean it.')
    end
  end

  describe 'GET /:operation/:number1/:number2' do
    it 'adds two numbers together' do
      get '/add/215/93'

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('308')
    end

    it 'subtracts the second number from the first' do
      get '/subtract/291/174'

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('117')
    end

    it 'multiplies two numbers together' do
      get '/multiply/12/11'

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('132')
    end

    it 'divides the first number by the second number' do
      get '/divide/612/4'

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('153')
    end
  end
end