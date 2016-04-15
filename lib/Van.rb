require_relative 'Garage'
require_relative 'DockingStation'

class Van

	attr_reader :bikes

	def initialize
		@bikes = []
	end

	def collect_broken(station)
  		collect("broken",station)
	end
	
	def collect_working(garage)
  		collect("working",garage)
  	end
  	
  	def deliver_broken(garage)
    	garage.receive_broken(@bikes)
    	@bikes.delete_if{|bike| bike.broken? }
  	end

  	def deliver_working(station)
  		station.take(@bikes.reject{|bike| bike.broken?},self)
  	end

  	def update_stock(bikes)
  		@bikes.delete_if{|bike| !bike.broken? }
  		@bikes += bikes
  	end

  	private

  	def collect(type,location)
  		if type == "broken"
  			@bikes += location.bikes.select{|bike| bike.broken?}
  			location.remove_broken_bikes
  		else
  			@bikes += location.bikes.reject{|bike| bike.broken?}
  			location.remove_working_bikes
  		end
  	end

end