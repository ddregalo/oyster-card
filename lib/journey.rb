class Journey
  attr_reader :journey_history
  attr_reader :single_journey
  MIN_FARE = 1
  PENALTY_FARE = 6
  def initialize
    @journey_history = []
    @single_journey = {:entry => nil , :exit => nil}
  end

  def start_journey(station)
    @single_journey[:entry] = station
  end

  def finish_journey(station)
    @single_journey[:exit] = station
    @journey_history << @single_journey
    # @single_journey[:entry] = nil
  end

  def fare
    if (@single_journey[:entry] == nil) || (@single_journey[:exit] == nil)
      PENALTY_FARE
    else
      MIN_FARE
    end
  end

  def complete?
    @single_journey.inlcude?(nil) ? false : true
  end

  def in_journey?
    return true if @single_journey[:entry]
  end
end

# starting a journey,
# finishing a journey,
# calculating the fare of a journey,
# returning whether or not the journey is complete
