require_relative 'Garage'
require_relative 'DockingStation'

class Van

	attr_reader :bikes

	def initialize(capacity=20)
		@bikes = []
    @capacity = capacity
	end

  def take(bikes,source)
    until full? or bikes.empty?
      @bikes << bikes.pop
    end
    source.update_stock(bikes)
  end

  def collect(source)
    source.give_up(self)
  end
  	
	def deliver_broken(garage)
    garage.take(@bikes.select{|bike| bike.broken?},self)
  end

  def deliver_working(station)
  	station.take(@bikes.reject{|bike| bike.broken?},self)
  end

  def update_stock(bikes)
  	if bikes.all?{|bike| bike.broken?}
      @bikes.delete_if{|bike| bike.broken? }
    else
      @bikes.delete_if{|bike| !bike.broken? }
    end
  	 @bikes += bikes
  end

  	private

    def full?
      @bikes.length == @capacity
    end

end