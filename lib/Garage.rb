require_relative 'BikeContainer'
require_relative 'VanGarageMix'

class Garage
  include BikeContainer
  include VanGarageMix

  def initialize(capacity=20)
    @bikes = []
    @capacity = capacity
  end

  def fix_bikes
  	@bikes = @bikes.map do |bike|
      bike.fix
    end
    @bikes
  end

private

  def full?
    @bikes.length == @capacity
  end

end