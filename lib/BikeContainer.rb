module BikeContainer

	attr_reader :bikes
	
	def take(bikes,source)
    until full? or bikes.empty?
      @bikes << bikes.pop
    end
    source.update_stock(bikes)
  end

  def update_stock(bikes)
    if bikes.all?{|bike| bike.broken?}
      @bikes.delete_if{|bike| bike.broken? }
    else
      @bikes.delete_if{|bike| !bike.broken? }
    end
     @bikes += bikes
  end

end