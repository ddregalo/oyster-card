class Journey
  attr_reader :journey_history, :single_journey, :fare
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @journey_history = []
    @single_journey = {:entry => nil , :exit => nil}
  end

  def start_journey(station)
    @single_journey[:entry] = station
  end

  def current_fare
    if @single_journey[:entry] == nil || @single_journey[:exit] == nil
      PENALTY_FARE
    else
      MIN_FARE
    end
  end

  # def complete?
  #   return true if (@single_journey[:entry] != nil) && (@single_journey[:exit] != nil)
  # end

  def finish_journey(station)
    @single_journey[:exit] = station
    @fare = current_fare
    @journey_history << @single_journey
    current_journey
  end

  private
  def current_journey
    @single_journey = {:entry => nil, :exit => nil} if !@single_journey.include?(nil)
    @single_journey
  end
end


# NOTES
# Touch-in + touch-put (normal case) works
# Touch-out (no touchin) works
# touchin (no touchout) - doesn't work

# returning whether or not the journey is complete
