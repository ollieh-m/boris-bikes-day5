require './lib/DockingStation'
require './lib/Van'
require './lib/Garage'

# Initialize objects
station = DockingStation.new
garage = Garage.new
van = Van.new
bike = Bike.new
bike_array = Array.new(10) {Bike.new}

#Print initialized objects
p "Docking Station: #{station}"
p "Garage: #{garage}"
p "Van: #{van}"
p "Bike: #{bike}"
puts
p "Array of Bikes: #{bike_array}"


# #Scenario_03
# bike.report_broken
# station.dock(bike)
# puts
# p station.broken?
# puts
# p station.release_bike

#Scenario_04
broken_bikes = []
bike_array.each do |bike| 
	bike.report_broken
	broken_bikes.push(bike)
end
garage.receive_broken(broken_bikes)
garage.fix_bikes
p garage.bikes


#Scenario_01
# bike.report_broken
# station.dock(bike)
# p van.collect_broken_bikes(station)

#Scenation_02
# p station
# puts
# bike_array.each { |bikes|
# 	bikes.report_broken
# 	station.dock(bikes)
# }
# puts
# p van.collect_broken_bikes(station)
# puts
# p station
