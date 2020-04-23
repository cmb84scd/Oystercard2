require 'journey'

describe Journey do

  describe '#start_journey' do
    let(:station) { double("Tube station", :name => "Oxford") }

    it 'Expects to record the entry station' do
      station = double("Tube station", :name => "Oxford")
      expect { subject.start_journey(station) }.to change {subject.entry_station}.to(station)
    end
  end

  describe '#finish_journey' do
    let(:station) { double("Tube station", :name => "Oxford") }
    it 'sets the entry_station variable to nil' do
      subject.start_journey(station)
      expect { subject.finish_journey(station) }.to change { subject.entry_station }.to nil
    end

    it 'adds entry station and exit station to journeys array as a hash' do
      expect {subject.finish_journey(station)}.to change{subject.journeys}.to [{entry: subject.entry_station, exit: station}]
    end
  end

  describe '#in_journey?' do
    let(:station) { double("Tube station", :name => "Oxford")}
    it 'infers its status based on existence of entry station' do
      expect { subject.start_journey(station) }.to change { subject.in_journey? }.from(false).to(true)
    end
  end

  describe '#journeys' do
    it 'journeys is empty when journey is initialized' do
      expect(subject.journeys).to eq []
    end
  end
end
