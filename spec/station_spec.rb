require 'station'

describe Station do
  let(:fake_station) { double 'station' }

  it 'Should create journey_stations as empty array' do
    expect(subject.journey_stations).to eq []
  end

  it 'Should initialize with current_station equal to nil' do
    expect(subject.current_station.values).to eq [nil, 0]
  end

  it 'Should initialize tube_map array' do
    expect(subject.tube_map).to eq([
    { :name => "Clapham", :zone => 3 },
    { :name => "Stockwell", :zone => 3 },
    { :name => "Bank", :zone => 2 },
    { :name => "Old Street", :zone => 1 }
    ])
  end

  describe '#add_station' do

    it 'Should add station to current_station name and update journey_stations' do
      subject.add_station(:fake_station)
      expect(subject.journey_stations[0][:name]).to eq :fake_station
    end

    it 'Should add station zone number to current_station zone and update journey_stations' do
      allow_any_instance_of(Station).to receive(:zone_calc).with(:fake_station).and_return(1) do
        subject.add_station(:fake_station)
        expect(subject.journey_stations[0][:zone]).to eq 1
      end
    end

    it 'Should reset current_station name and zone to nil' do
      subject.add_station(:fake_station)
      expect(subject.current_station.values).to eq [nil, nil]
    end
  end

  describe '#clear_journey_stations' do

    it 'Should reset journey_stations to empty array' do
      allow_any_instance_of(Station).to receive(:zone_calc).with(:fake_station).and_return(1) do
        subject.add_station(:fake_station)
        subject.clear_journey_stations
        expect(subject.journey_stations).to eq []
      end
    end
  end
end
