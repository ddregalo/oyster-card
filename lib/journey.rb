class Journey
  attr_reader :journey_history, :single_journey, :fare
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(station_class)
    @journey_history = []
    @single_journey = {:entry => nil , :exit => nil}
    @station_class = station_class
  end

  def start_journey(station)
    @station_class.add_station(station)
    @single_journey[:entry] = station
  end

  def fare_calculator
    if @single_journey.values.include?(nil)
      PENALTY_FARE
    else
      MIN_FARE + ((@station_class.journey_stations[0][:zone]) - (@station_class.journey_stations[1][:zone])).abs
    end
  end

  def add_to_history
    @journey_history << @single_journey
  end

  def finish_journey(station)
    @station_class.add_station(station)
    @single_journey[:exit] = station
    @fare = fare_calculator
    add_to_history
    current_journey
    @station_class.clear_journey_stations
  end


  private
  def current_journey
    @single_journey = {:entry => nil, :exit => nil} if !@single_journey.include?(nil)
    @single_journey
  end
  # def complete?
  #   return true if (@single_journey[:entry] != nil) && (@single_journey[:exit] != nil)
  # end
end


# NOTES
# Touch-in + touch-put (normal case) works
# Touch-out (no touchin) works
# touchin (no touchout) - doesn't work

# returning whether or not the journey is complete
