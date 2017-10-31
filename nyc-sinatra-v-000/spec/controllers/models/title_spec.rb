require 'spec_helper'

describe "Title" do
  before do 
    @figure = Figure.create(:name => "Fiorello LaGuardia") 
    @mayor = Title.create(:name => "Mayor")
  end


  it "has a name" do 
    expect(@mayor.name).to eq("Mayor")
  end

  it "has many figures" do 
    @mayor.figures << @figure
    expect(@mayor.figures).to include(@figure)
  end
end
