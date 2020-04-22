require 'oystercard'

describe Oystercard do

  describe 'balance' do

    it 'responds to balance' do
      expect(subject).to respond_to(:balance)
    end

    it 'balance has 0' do
      expect(subject.balance).to eq(0)
    end

  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

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
    it {is_expected.to respond_to (:touch_in)}

    it 'Touch in sets in_journey to true' do
      subject.top_up(Oystercard::MIN_CHARGE)
      expect { subject.touch_in }.to change{subject.in_journey}.from(false).to(true)
    end

    it 'raises error if balance not sufficient' do
      expect { subject.touch_in }.to raise_error "Insufficient funds"
    end

  end

  describe '#touch_out' do
    it {is_expected.to respond_to (:touch_out)}

    it 'Touch out sets in_journey to false' do
      subject.top_up(Oystercard::MIN_CHARGE)
      subject.touch_in
      expect { subject.touch_out }.to change{subject.in_journey}.from(true).to(false)
    end

    it 'Touch out deducts minimum fare' do
      expect { subject.touch_out }.to change{subject.balance}.by -Oystercard::MIN_CHARGE
    end
  end

end
