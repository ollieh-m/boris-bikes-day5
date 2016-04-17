require_relative 'BikeContainer'
require_relative 'VanStationMix'

class DockingStation
  include BikeContainer
  include VanStationMix

  def initialize(capacity=20)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    raise 'No bikes available' if empty?
    raise 'No working bikes available' if broken?
    release = @bikes.reject{|bike| bike.broken?}.pop
    @bikes.delete(release)
    release
	end

  def dock(bike)
    fail "Dock already full" if full?
    @bikes << bike
  end

private

  def full?
    @bikes.count >= @capacity
  end

  def empty?
    @bikes.empty?
  end
  
  def broken?
    @bikes.reject{ |bike| bike.broken? }.empty?
  end

end
