require_relative 'bike'

class DockingStation

  attr_reader :bikes

  DEFAULT_CAPACITY = 20

  def initialize(num=DEFAULT_CAPACITY)
    @bikes = []
    @Capacity = num
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

  def remove_broken_bikes
    @bikes = @bikes.reject{|bike| bike.broken?}
  end

private

  def full?
    @bikes.count >= @Capacity
  end

  def empty?
    @bikes.empty?
  end
  
  def broken?
    @bikes.reject { |bike| bike.broken? }.empty?
  end

end
