require 'oystercard'
require 'journey'

describe OysterCard do
  let(:fake_station) { double('fake_station') }
  let(:fake_station_class) { double('station') }
  subject(:subject) { OysterCard.new(Journey.new(fake_station_class)) }

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
    it 'Should raise error if balance is not greater than MIN FARE of 1' do
      expect{ subject.touch_in(fake_station) }.to raise_error "Insufficient funds"
    end
  end

  describe '#touch_out' do
    it 'Should deduct the MIN FARE from balance' do
      subject.top_up(1)
      subject.touch_in(:fake_station)
      expect { subject.touch_out(:fake_station) }.to change{ subject.balance }.by(-Journey::MIN_FARE)
    end
  end
end
