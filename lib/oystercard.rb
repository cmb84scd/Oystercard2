class Oystercard
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    if @balance + amount >= 90
      raise 'Error: balance cannot be more than £90'
    end
    @balance += amount
  end

end
