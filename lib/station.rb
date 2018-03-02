class Station
  attr_reader :journey_stations, :current_station, :tube_map

  def initialize
    @current_station = {:name => nil , :zone => 0}
    @journey_stations = []
    @tube_map = [
    {:name => "Clapham", :zone => 3},
    {:name => "Stockwell", :zone => 3},
    {:name => "Bank", :zone => 2},
    {:name => "Old Street", :zone => 1}
    ]
  end

  def add_station(station)
    @current_station[:name] = station
    @current_station[:zone] = zone_calc(station)
    @journey_stations << @current_station
    @current_station = {:name => nil, :zone => nil}
  end

  def clear_journey_stations
    @journey_stations = []
  end

  private
  def zone_calc(station)
    @tube_map.map do |station|
      return station[:zone] if @current_station[:name] == station[:name]
    end
  end
end
