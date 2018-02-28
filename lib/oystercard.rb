class OysterCard

  attr_reader :balance
  attr_accessor :in_journey
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @entry_station = ""
  end

  def top_up(amount)
    raise "Cannot top up, max balance of card is #{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in
    raise "Insufficient funds" if @balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
