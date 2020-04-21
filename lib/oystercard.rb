class Oystercard
  attr_reader :balance

  MAX_BALANCE = 90
  
  def initialize
    @balance = 0
  end

  def top_up(amount)
    if @balance + amount >= MAX_BALANCE
      raise 'Error: balance cannot be more than £90'
    end
    @balance += amount
  end

end
