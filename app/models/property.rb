class Property < ActiveRecord::Base
  attr_accessible :bedroom_count, :latitude, :longitude, :name, :rented_at, :image_path
  scope :valid, where("rented_at IS NULL")
  scope :invalid, where("rented_at IS NOT NULL")
  #I am not claiming that I wrote the following :near scope.  It is an alternative to using a postgresql (which would probably be the preferred option).  The line of least resistance for this test really, but will still work well
  scope :near, lambda{ |options|
    origin = options[:origin]
    if (origin).is_a?(Array)
      origin_lat, origin_lng = origin
    else
      origin_lat, origin_lng = origin.lat, origin.lng
    end
    origin_lat, origin_lng = deg2rad(origin_lat), deg2rad(origin_lng)
    within = options[:within]
    {
      :conditions => %(
                      (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(#{table_name}.latitude))*COS(RADIANS(#{table_name}.longitude))+
                      COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(#{table_name}.latitude))*SIN(RADIANS(#{table_name}.longitude))+
                      SIN(#{origin_lat})*SIN(RADIANS(#{table_name}.latitude)))*3963) <= #{within}
      ),
      :select => %( #{table_name}.*,
                      (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(#{table_name}.latitude))*COS(RADIANS(#{table_name}.longitude))+
                      COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(#{table_name}.latitude))*SIN(RADIANS(#{table_name}.longitude))+
                      SIN(#{origin_lat})*SIN(RADIANS(#{table_name}.latitude)))*3963) AS distance
                    )
    }
  }

  class << self
    def deg2rad(degrees)
      degrees * Math::PI / 180
    end
    def kilo_to_miles(kilo)
      kilo * 0.62137
    end
    def search(search_object)
      scope=self
      scope=scope.where("name ilike ?","%#{search_object[:name]}%") unless search_object[:name].nil? or search_object[:name].empty?
      scope=scope.where("bedroom_count=?",search_object[:bedroom_count]) unless search_object[:bedroom_count].nil? or search_object[:bedroom_count].empty?
      scope
    end

    def alternatives_to(invalid_results)
      scope=self.valid
      results=[]
      invalid_results.each do |invalid_result|
        results.concat scope.where("bedroom_count>=?",invalid_result.bedroom_count).near(:origin => [invalid_result.latitude, invalid_result.longitude], :within => kilo_to_miles(20)).order("distance ASC").all
      end
      results
    end
  end

  #As the distance ends up as a string, convert it here
  def distance
    d=read_attribute(:distance)
    d.nil? ? nil : d.to_f
  end

end
