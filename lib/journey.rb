class Journey

  attr_reader :entry_station, :journeys

  def initialize
    @entry_station = nil
    @journeys = []
  end

  def start_journey(station)
    @entry_station = station
  end

  def finish_journey(station)
    @journeys << {entry: @entry_station, exit: station}
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end
end
