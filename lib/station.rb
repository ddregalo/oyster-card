class Station
  attr_reader :name, :zone, :tube_map

  def initialize
    @tube_map = [
    {:name => "Clapham", :zone => 3},
    {:name => "Stockwell", :zone => 3},
    {:name => "Bank", :zone => 2},
    {:name => "Old Street", :zone => 1}
    ]
  end

end
