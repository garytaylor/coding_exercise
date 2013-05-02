Given(/^I am a customer$/) do
  #This does nothing, purely syntactical sugar
end
Given(/^there are the default 5 properties in the database$/) do
  @properties={
    :flat1 => FactoryGirl.create(:property, :name => "Sizeable house", :bedroom_count => 2, :latitude => 51.501000, :longitude => -0.142000),
    :flat2 => FactoryGirl.create(:property, :name => "Trendy flat", :bedroom_count => 2, :latitude => 51.523778, :longitude => -0.205500),
    :flat3 => FactoryGirl.create(:property, :name => "Flat with stunning view", :bedroom_count => 2, :latitude => 51.504444, :longitude => -0.086667),
    :flat4 => FactoryGirl.create(:property, :name => "Unique flat", :bedroom_count => 1, :latitude => 51.538333, :longitude => -0.013333),
    :flat5 => FactoryGirl.create(:property, :name => "Isolated house", :bedroom_count => 1, :latitude => 50.066944, :longitude => -5.746944)
  }
end