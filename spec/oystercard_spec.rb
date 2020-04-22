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

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "deducts certain amount from the balance" do
      expect {subject.deduct(10)}.to change {subject.balance}.by(-10)
    end

  end

  describe '#touch_in' do
    it {is_expected.to respond_to (:touch_in)}

    it 'Touch in sets in_journey to true' do
      expect { subject.touch_in }.to change{subject.in_use}.from(false).to(true)
    end
  end

  describe '#touch_out' do
    it {is_expected.to respond_to (:touch_out)}

    it 'Touch out sets in_journey to false' do
      subject.touch_in
      expect { subject.touch_out }.to change{subject.in_use}.from(true).to(false)
    end
  end

  describe '#in_journey' do
    it 'returns true if in_use is true' do
      subject.touch_in
      expect(subject.in_journey).to eq true
    end
  end
end
