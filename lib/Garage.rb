require_relative 'bike'

class Garage
  attr_reader :bikes

  def initialize(capacity=20)
    @bikes = []
    @capacity = capacity
  end

  def take(bikes,van)
    until full? or bikes.empty?
      @bikes << bikes.pop
    end
    van.update_stock(bikes)
  end

  def fix_bikes
  	@bikes = @bikes.map do |bike|
      bike.fix
    end
    @bikes
  end

  def give_up(van)
    van.take(@bikes.reject{|bike| bike.broken? },self)
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