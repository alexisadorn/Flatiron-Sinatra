require 'spec_helper'

describe "Figure" do
  before do 
    @figure = Figure.create(:name => "Fiorello LaGuardia") 

    @airport =  Landmark.create(:name => "LG Airport") 
    @library = Landmark.create(:name => "Library")

    @mayor = Title.create(:name => "Mayor")
    @councilman = Title.create(:name => "Councilman")
    
  end


  it "has a name" do 
    expect(@figure.name).to eq("Fiorello LaGuardia")
  end

  it "has many landmarks" do 
    @figure.landmarks << @airport
    @figure.landmarks << @library
    expect(@figure.landmarks).to include(@airport)
    expect(@figure.landmarks).to include(@library)
  end

  it "has many titles" do 
    @figure.titles << @mayor
    @figure.titles << @councilman
    expect(@figure.titles).to include(@mayor)
    expect(@figure.titles).to include(@councilman)
  end
end
