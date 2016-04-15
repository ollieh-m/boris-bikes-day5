require_relative 'bike'

class Garage
  attr_reader :bikes

  def initialize
    @bikes = []
  end

  def receive_broken(broken_bikes)
    @bikes += broken_bikes
  end

  def fix_bikes
  	@bikes.each do |bike|
  		bike.fix
  	end
  end
end