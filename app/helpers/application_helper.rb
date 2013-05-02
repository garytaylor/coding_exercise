module ApplicationHelper
  def miles_to_kilometres(miles,options={:round_to => 1})
    miles.nil? ? '' : (miles * 1.609344).round(options[:round_to])
  end
  def format_distance(miles, options={:format => :km, :round_to => 1})
    return "" if miles.nil?
    case options[:format]
      when :km then "#{miles_to_kilometres(miles,options)} km"
    end


  end
end
