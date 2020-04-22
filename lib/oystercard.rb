class Oystercard
  attr_reader :balance, :in_use

  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "Error: Maximum balance cannot be more than £#{MAX_BALANCE}" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "Insufficient funds" if @balance < MIN_CHARGE
    @in_use = true
    in_journey
  end

  def touch_out
    @in_use = false
    in_journey
  end

  def in_journey
    if @in_use == false
      false
    else
      true
    end
  end
end
