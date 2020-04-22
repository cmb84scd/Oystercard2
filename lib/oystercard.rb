class Oystercard
  attr_reader :balance, :in_journey

  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Error: Maximum balance cannot be more than £#{MAX_BALANCE}" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in
    fail "Insufficient funds" if @balance < MIN_CHARGE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MIN_CHARGE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
