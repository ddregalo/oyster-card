require 'station'

describe Station do

  it 'Should create name instance variable' do
    expect(subject.name).to eq nil
  end

  it 'Should create zone instance variable' do
    expect(subject.zone).to eq nil
  end
end
