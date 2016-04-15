require 'Garage'

describe Garage do
  
  let(:broken_bikes) {[spy(:broken_bike1), spy(:broken_bike2)]}
  
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

end