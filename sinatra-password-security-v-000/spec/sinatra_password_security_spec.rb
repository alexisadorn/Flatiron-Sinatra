describe "App" do 

  describe "GET '/'" do 
    it 'returns a 200 status code' do 
      get '/'
      expect(last_response.status).to eq(200)
    end

    it 'returns contains a login and signup links' do 
      get '/'
      expect(last_response.body).to include('Please <a href="/signup">Sign Up</a> or <a href="/login">Log In</a> to continue')
    end
  end

  describe "GET '/signup'" do 
    it 'returns a 200 status code' do 
      get '/signup'
      expect(last_response.status).to eq(200)
    end

    it 'returns contains a form to login' do 
      visit '/signup'
      expect(page).to have_selector("form")
      expect(page).to have_field(:username)
      expect(page).to have_field(:password)
    end
  end

  describe "POST '/signup'" do 
    it 'returns a 200 status code' do 
      visit '/signup'
      fill_in "username", :with => "student1"
      fill_in "password", :with => "test"
      
      click_button "Sign Up"
      expect(page.current_path).to eq('/login')
      expect(page.status_code).to eq(200)
    end
  end

  describe "GET '/login'" do 
    it 'returns a 200 status code' do 
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'loads a form to login' do 
      visit '/login'
      expect(page).to have_selector("form")
      expect(page).to have_field(:username)
      expect(page).to have_field(:password)
    end
  end

  describe "POST '/login'" do 
    it 'returns a 200 status code' do 
      user = User.create(:username => "student1", :password => "test")
      visit '/login'
      fill_in "username", :with => "student1"
      fill_in "password", :with => "test"
      
      click_button "Log In"
      expect(page.current_path).to eq('/success')
      expect(page.status_code).to eq(200)
    end
  end

  describe "GET '/success'" do 
    it 'displays the username' do 
      user = User.create(:username => "student1", :password => "test")
      visit '/login'
      fill_in "username", :with => "student1"
      fill_in "password", :with => "test"
      
      click_button "Log In"

      expect(page.body).to include(user.username)
    end
  end

  describe "GET '/failure'" do 
    it 'displays failure message' do 
      visit '/failure'

      expect(page.body).to include("Houston, We Have a Problem")
    end
  end

  describe "GET '/logout'" do 
    it 'clears the session hash and redirects to home page' do 
      user = User.create(:username => "student1", :password => "test")
      visit '/login'
      fill_in "username", :with => "student1"
      fill_in "password", :with => "test"
      click_button "Log In"
      get '/logout'
      expect(session.keys).to eq([])
      expect(session.values).to eq([])
      expect(last_response.location).to eq("http://example.org/")
    end
  end
end