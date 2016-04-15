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
  	@bikes = @bikes.map do |bike|
      bike.fix
    end
    @bikes
  end

  def remove_working_bikes
    @bikes.delete_if{|bike| bike.broken? == false}
  end

end