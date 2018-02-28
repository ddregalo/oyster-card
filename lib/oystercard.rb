class OysterCard

  attr_reader :balance
  attr_reader :journey_history
  attr_reader :journey

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @journey_history = []
    @journey = {:entry => nil , :exit => nil}
  end

  def top_up(amount)
    raise "Cannot top up, max balance of card is #{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MIN_FARE
    @journey[:entry] = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey[:exit] = station
    @journey_history << @journey
    @journey[:entry] = nil
  end

  def in_journey?
    return true if @journey[:entry]
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
