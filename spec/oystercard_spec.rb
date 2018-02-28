require 'oystercard'

describe OysterCard do
  subject(:oystercard) { OysterCard.new } #gives fresh instance of Oystercard

  it 'Should initialize with default balance of 0' do
      expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    # subject(:oystercard) { OysterCard.new }
    it 'Should add the top_up amount to balance' do
      expect(subject.top_up(10)).to eq(subject.balance)
    end

    it 'Should raise error if top_up amount brings card over limit' do
      expect{ subject.top_up(91) }.to raise_error "Cannot top up, max balance of card is #{OysterCard::MAX_BALANCE}"
    end
  end

  describe '#deduct' do
    it 'Should deduct the min fare amount from balance' do
      allow_any_instance_of(OysterCard).to receive(:deduct) do
        expect(subject.deduct(1)).to eq(subject.balance)
      end
    end
  end

  describe '#touch_in' do
    it 'Should set in_journey to true' do
      subject.top_up(1)
      expect(subject.touch_in).to eq(true)
    end

    it 'Should raise error if balance is not greater than MIN FARE of 1' do
      expect{ subject.touch_in }.to raise_error "Insufficient funds"
    end
  end

  describe '#touch_out' do
    it 'Should set in_journey to false' do
      expect(subject.touch_out).to eq(false)
    end

    it 'Should deduct the MIN FARE from balance' do
      subject.top_up(1)
      expect { subject.touch_out }.to change{ subject.balance }.by(-OysterCard::MIN_FARE)
    end
  end

  describe '#in_journey?' do
    it 'Should return in_journey status' do
      expect(subject.in_journey?).to eq(subject.in_journey)
    end
  end
end
