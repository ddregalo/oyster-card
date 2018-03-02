require 'station'

describe Station do

  it 'Should create name instance variable' do
    expect(subject.name).to eq nil
  end

  it 'Should create zone instance variable' do
    expect(subject.zone).to eq nil
  end

  it 'Should initialize tube_map array' do
    expect(subject.tube_map).to eq([
    {:name => "Clapham", :zone => 3},
    {:name => "Stockwell", :zone => 3},
    {:name => "Bank", :zone => 2},
    {:name => "Old Street", :zone => 1}
    ])
  end
end
