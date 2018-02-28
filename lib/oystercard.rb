class OysterCard

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journey_history

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @journey_history = []
  end

  def top_up(amount)
    raise "Cannot top up, max balance of card is #{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @entry_station = nil
    @exit_station = station
  end

  def in_journey?
    return true if @entry_station
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
