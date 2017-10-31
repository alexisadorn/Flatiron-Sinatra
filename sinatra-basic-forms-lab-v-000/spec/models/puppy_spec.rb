describe 'Puppy class' do 
  let!(:puppy) { Puppy.new("brad", "black lab", 2) }

  it 'can create a new instance of the puppy class' do
    expect(Puppy.new("brad", "black lab", 2)).to be_an_instance_of(Puppy)
  end

  it 'can read a puppy name' do 
    expect(puppy.name).to eq("brad")
  end

  it 'can read a puppy breed' do 
    expect(puppy.breed).to eq("black lab")
  end

  it 'can read a puppy age' do 
    expect(puppy.age).to eq(2)
  end

  it 'can change puppy age' do 
    puppy.age = 3
    expect(puppy.age).to eq(3)
  end

  it 'can change puppy name' do 
    puppy.name = "brad the beast"
    expect(puppy.name).to eq("brad the beast")
  end

  it 'can change puppy breed' do 
    puppy.breed = "the best black lab"
    expect(puppy.breed).to eq("the best black lab")
  end
end