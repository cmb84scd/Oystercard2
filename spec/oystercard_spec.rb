require 'oystercard'

describe Oystercard do

  describe 'balance' do

    it 'balance has 0' do
      expect(subject.balance).to eq(0)
    end

  end

  describe '#top_up' do

    it '#top_up will increase balance' do
      expect { subject.top_up(10) }.to change { subject.balance }.by 10
    end

    it 'raises an error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up 1 }.to raise_error "Error: Maximum balance cannot be more than £#{max_balance}"
    end
  end

  describe '#touch_in' do
    let(:station) { double("Tube station", :name => "Oxford") }
    it 'raises error if balance not sufficient' do
      expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
    end

  end

  describe '#touch_out' do
    let(:station) { double("Tube station", :name => "Oxford")}

    it 'Touch out deducts minimum fare if you have tapped in at entry and exit' do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{subject.balance}.by -Oystercard::MIN_CHARGE
    end

    it 'deducts maximum PENALTY_FARE' do
      expect { subject.touch_out(station) }.to change{subject.balance}.by -Oystercard::PENALTY_FARE
    end

  end

end
