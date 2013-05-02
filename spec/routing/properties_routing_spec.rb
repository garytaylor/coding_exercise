require "spec_helper"

describe PropertiesController do
  describe "routing" do

    it "routes to #search" do
      get("/properties/search").should route_to("properties#search")
    end

    it "routes to #search_results" do
      get("/properties/search_results").should route_to("properties#search_results")
    end

    it "routes to #show" do
      get("/properties/1").should route_to("properties#show", :id => "1")
    end


  end
end
