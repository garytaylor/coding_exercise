class PropertiesController < ApplicationController
  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @properties }
    end
  end

  # GET /properties/search
  # GET /properties/search.json
  def search
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @properties }
    end
  end
  # GET /properties/search_results
  # GET /properties/search_results.json
  def search_results
    base_scope=Property.search(params[:property])
    properties=base_scope.valid
    invalid_properties=base_scope.invalid

    if invalid_properties.count>0
      #We have some properties that are now rented out in the search results, so offer alternatives in @alternative_properties
      @alternative_properties=Property.alternatives_to(invalid_properties)
    end

    @properties = properties.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {:properties => @properties, :alternative_properties => @alternative_properties} }
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @property = Property.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @property }
    end
  end

end
