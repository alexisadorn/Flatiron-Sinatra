describe App do

  describe 'GET /' do
    
    it 'sends a 200 status code' do
      get '/'
      expect(last_response.status).to eq(200)
    end

    it 'renders welcome' do 
      visit '/'
      expect(page).to have_link("Click Here To List A Puppy")
    end
  end

  describe 'GET /NEW' do 
    it 'sends a 200 status code' do
      get '/new'
      expect(last_response.status).to eq(200)
    end

    it 'renders the form' do
      visit '/new'
      expect(page).to have_selector("form")
      expect(page).to have_field(:name)
      expect(page).to have_field(:breed)
      expect(page).to have_field(:age)
    end
  end

  describe 'POST /' do
    it "displays the puppy" do 
      visit '/new'

      fill_in(:name, :with => "Butch")
      fill_in(:breed, :with => "Mastiff")
      fill_in(:age, :with => "6 months")
      click_button "submit"
      expect(page).to have_text("Puppy Name:\nButch")
      expect(page).to have_text("Puppy Breed:\nMastiff")
      expect(page).to have_text("Puppy Age:\n6 months")
    end
  end

  
end