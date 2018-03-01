class OysterCard

  attr_reader :balance
  MAX_BALANCE = 90

  def initialize(journey, balance = 0)
    @balance = balance
    @journey = journey
  end

  def top_up(amount)
    raise "Cannot top up, max balance of card is #{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < Journey::MIN_FARE
    @journey.start_journey(station)
  end

  def touch_out(station)
    deduct(Journey::MIN_FARE)
    @journey.finish_journey(station)
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
