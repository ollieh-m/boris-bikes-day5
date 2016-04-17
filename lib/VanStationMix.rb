module VanStationMix

	def give_up_broken(destination)
    	destination.take(@bikes.select{|bike| bike.broken? },self)
  	end
  	
end