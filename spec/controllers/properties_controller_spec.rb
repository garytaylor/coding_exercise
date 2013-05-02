require 'spec_helper'


describe PropertiesController do
  before :each do
    Property.delete_all
    @properties={
      :flat1 => FactoryGirl.create(:property, :name => "Sizeable house", :bedroom_count => 2, :latitude => 51.501000, :longitude => -0.142000),
      :flat2 => FactoryGirl.create(:property, :name => "Trendy flat", :bedroom_count => 2, :latitude => 51.523778, :longitude => -0.205500),
      :flat3 => FactoryGirl.create(:property, :name => "Flat with stunning view", :bedroom_count => 2, :latitude => 51.504444, :longitude => -0.086667),
      :flat4 => FactoryGirl.create(:property, :name => "Unique flat", :bedroom_count => 1, :latitude => 51.538333, :longitude => -0.013333),
      :flat5 => FactoryGirl.create(:property, :name => "Isolated house", :bedroom_count => 1, :latitude => 50.066944, :longitude => -5.746944)
    }

  end

  # This should return the minimal set of attributes required to create a valid
  # Property. As you add validations to Property, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PropertiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET search" do
    it "Simply renders the search form, nothing else" do
      get :search, {}, valid_session
    end
  end

  describe "GET search_results" do
    it "Should find 3 properties with 2 bedrooms" do
      get :search_results, :property => {:bedroom_count=>2}
      assigns[:properties].should have(3).items
      assigns[:alternative_properties].should be_nil
    end
    it "Should find 2 properties with 1 bedrooms" do
      get :search_results, :property => {:bedroom_count=>1}
      assigns[:properties].should have(2).items
      assigns[:alternative_properties].should be_nil
    end
    it "Should find alternatives when searching for a specific property that is rented" do
      Property.find_by_name("Unique flat").update_attribute :rented_at , Time.now
      get :search_results, :property => {:name => "Unique flat"}
      assigns[:properties].should have(0).items
      assigns[:alternative_properties].should have(3).items
      assigns[:alternative_properties].should eql [
        @properties[:flat3],
        @properties[:flat1],
        @properties[:flat2]
                                                  ]
    end
  end


end
