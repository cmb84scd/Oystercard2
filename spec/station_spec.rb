require 'station'

describe Station do
  station = Station.new("Waterloo", 1)
  it 'returns a name' do
    expect(station.name).to eq("Waterloo")
  end

  it 'returns a zone' do
    expect(station.zone).to eq(1)
  end
end
