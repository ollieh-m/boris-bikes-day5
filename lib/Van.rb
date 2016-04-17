require_relative 'BikeContainer'
require_relative 'VanStationMix'
require_relative 'VanGarageMix'

class Van
  include BikeContainer
  include VanStationMix
  include VanGarageMix

	def initialize(capacity=20)
		@bikes = []
    @capacity = capacity
	end

  def collect(source)
    source.give_up(self)
  end

private

  def full?
    @bikes.length == @capacity
  end

end