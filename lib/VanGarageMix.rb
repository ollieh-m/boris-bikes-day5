module VanGarageMix

	def give_up_working(destination)
  		destination.take(@bikes.reject{|bike| bike.broken?},self)
  	end

end