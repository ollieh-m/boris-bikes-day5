require_relative 'Garage'
require_relative 'DockingStation'

class Van

	attr_reader :bikes

	def initialize
		@bikes = []
	end

	def collect_broken(station)
		@bikes += station.bikes.select{|bike| bike.broken?}
    	station.remove_broken_bikes
	end

  	def deliver_broken(garage)
    	garage.receive_broken(@bikes)
    	@bikes.delete_if{|bike| bike.broken? }
  	end

  	def collect_working(garage)
  		@bikes += garage.bikes.reject{|bike| bike.broken?}
  		garage.remove_working_bikes
  	end

  	def deliver_working(station)
  		station.take(@bikes.reject{|bike| bike.broken?},self)
  	end

  	def update_stock(bikes)
  		@bikes.delete_if{|bike| !bike.broken? }
  		@bikes += bikes
  	end

end