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

  def give_up(van)
    van.take(@bikes.select{|bike| bike.broken? },self)
  end

  def update_stock(bikes)
    if bikes.all?{|bike| bike.broken?}
      @bikes.delete_if{|bike| bike.broken? }
    else
      @bikes.delete_if{|bike| !bike.broken? }
    end
     @bikes += bikes
  end

  def take(bikes,van)
    until full? or bikes.empty?
      @bikes << bikes.pop
    end
    van.update_stock(bikes)
  end

private

  def full?
    @bikes.count >= @Capacity
  end

  def empty?
    @bikes.empty?
  end
  
  def broken?
    @bikes.reject{ |bike| bike.broken? }.empty?
  end

end
