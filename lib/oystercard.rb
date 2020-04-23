require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey

  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    raise "Error: Maximum balance cannot be more than £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MIN_CHARGE
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journey.finish_journey(station)
    deduct(MIN_CHARGE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
