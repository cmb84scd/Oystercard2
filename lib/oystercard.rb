class Oystercard
  attr_reader :balance, :entry_station

  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @entry_station = false
  end

  def top_up(amount)
    raise "Error: Maximum balance cannot be more than £#{MAX_BALANCE}" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MIN_CHARGE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
