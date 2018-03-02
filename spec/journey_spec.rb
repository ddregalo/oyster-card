require 'journey'
require 'oystercard'

describe Journey do
  let(:fake_station_class) { double('station') }
  let(:fake_station) { double('fake_station') }
  subject{ described_class.new(fake_station_class) }

  it 'Should initialize with empty journey_history' do
    expect(subject.journey_history).to eq([])
  end

  describe '#start_journey' do
    it "Should record entry station upon touch in" do
      expect(subject.start_journey(:fake_station)).to eq(subject.single_journey[:entry])
    end
  end

  describe '#add_to_history' do
    it 'Should add the current single journey to journey history' do
      subject.start_journey(:fake_station)
      subject.finish_journey(:fake_station)
      expect(subject.journey_history).to eq([{:entry => :fake_station , :exit => :fake_station}])
    end
  end


  describe '#current_journey' do
    # testing the private class current_journey
    it 'Should return the incomplete journey hash if journey not complete' do
      allow_any_instance_of(Journey).to receive(:current_journey) do
        subject.start_journey(:fake_station)
        subject.finish_journey(:fake_station)
        expect(subject.single_journey).to eq({:entry => nil, :exit => nil})
      end
    end
  end

  describe '#finish_journey' do
    it 'Sould reset single journey entry and exit on touch out' do
      subject.start_journey(:fake_station)
      subject.finish_journey(:fake_station)
      expect(subject.single_journey.values).to eq([nil, nil])
    end

    it 'Should add single journey to journey history' do
      subject.start_journey(:fake_station)
      subject.finish_journey(:fake_station)
      expect(subject.journey_history).to eq([{:entry => :fake_station, :exit => :fake_station }])
    end
  end
end
