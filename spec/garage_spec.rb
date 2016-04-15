require 'Garage'

describe Garage do
  
  let(:broken_bikes) {[spy(:broken_bike1), spy(:broken_bike2)]}
  let(:broken_bikes_2) {[double(:broken_bike1,:fix => "a fixed bike"),
                        double(:broken_bike2,:fix => "a fixed bike")]}
  let(:mixed_bikes) {[double(:working_bike,:broken? => false),double(:broken_bike,:broken? => true)]}
  
  it 'receives bikes' do
    subject.receive_broken(broken_bikes)
    broken_bikes.each do |bike|
      expect(subject.bikes).to include bike
    end
  end

  it 'fixes broken bikes' do
  	subject.receive_broken(broken_bikes)
  	subject.fix_bikes
  	expect(broken_bikes[0]).to have_received(:fix)
  end

  it 'updates the bikes array with the results of .fix on each bike' do
    subject.receive_broken(broken_bikes_2)
    subject.fix_bikes
    expect(subject.bikes).to eq ["a fixed bike","a fixed bike"]
  end

  it 'gets rid of working bikes when remove_working_bikes is called' do
    subject.receive_broken(mixed_bikes)
    subject.remove_working_bikes
    expect(subject.bikes).to eq [mixed_bikes[1]]
  end

end