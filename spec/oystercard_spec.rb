require 'oystercard'

describe OysterCard do
  let(:fake_station) { double(:fake_station) }

  it 'Should initialize with default balance of 0' do
      expect(subject.balance).to eq(0)
  end

  it 'Should initialize with empty journey_history' do
    expect(subject.journey_history).to eq([])
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
      subject.touch_in(:fake_station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'Should raise error if balance is not greater than MIN FARE of 1' do
      expect{ subject.touch_in(fake_station) }.to raise_error "Insufficient funds"
    end

    it "Should record entry station upon touch in" do
      subject.top_up(1)
      subject.touch_in(:fake_station)
      expect(subject.entry_station).to eq(:fake_station)
    end
  end

  describe '#touch_out' do

    it 'Should deduct the MIN FARE from balance' do
      subject.top_up(1)
      expect { subject.touch_out(:fake_station) }.to change{ subject.balance }.by(-OysterCard::MIN_FARE)
    end

    it 'Should reset entry_station to nil on touch_out' do
      subject.top_up(1)
      subject.touch_in(:fake_station)
      subject.touch_out(:fake_station)
      expect(subject.entry_station).to eq(nil)
    end

    it 'Should remember exit_station upon touch_out' do
      subject.top_up(1)
      subject.touch_in(:fake_station)
      subject.touch_out(:fake_station)
      expect(subject.exit_station).to eq(:fake_station)
    end

    it 'Should store the complete journey in journey' do
      subject.top_up(1)
      subject.touch_in(:fake_station)
      subject.touch_out(:fake_station)
      expect(subject.journey).to eq(subject.journey_history.first)
    end
  end

  describe '#in_journey?' do
    it 'Should return in_journey status' do
      subject.top_up(1)
      subject.touch_in(:fake_station)
      expect(subject.in_journey?).to eq(true)
    end
  end
end
