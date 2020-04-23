require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey

  MAX_BALANCE = 90
  MIN_CHARGE = 1
  PENALTY_FARE = 6

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    raise "Error: Maximum balance cannot be more than £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station = nil)
    fail "Insufficient funds" if @balance < MIN_CHARGE
    @journey.start_journey(station)
  end

  def touch_out(station = nil)
    @journey.finish_journey(station)
    deduct
  end

  private

  def deduct
    if @journey.journeys[-1][:entry] == nil || @journey.journeys[-1][:exit] == nil
      @balance -= PENALTY_FARE
    else
      @balance -= MIN_CHARGE
    end
  end
end
