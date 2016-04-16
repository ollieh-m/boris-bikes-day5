require 'Garage'

describe Garage do
  let(:broken_bikes) {[ spy(:broken_bike1), spy(:broken_bike2) ]}
  let(:broken_bike) { double(:broken_bike) }
  let(:van) { spy(:van) }
  
  context '#take' do
    it 'should receive up to three bikes from the bikes array if the garage capacity is set to three' do
      garage = Garage.new(3)
      garage.take([broken_bike,broken_bike,broken_bike,broken_bike],van)
      expect(garage.bikes).to eq [broken_bike,broken_bike,broken_bike]
    end

    it 'should update the van\'s stock with the bikes it cannot take' do
      garage = Garage.new(3)
      garage.take([broken_bike,broken_bike,broken_bike,broken_bike],van)
      expect(van).to have_received(:update_stock).with([broken_bike])
    end
  end

  context '#fix_bikes' do
    let(:broken_bikes_2) {[double(:broken_bike1,:fix => "a fixed bike"), double(:broken_bike2,:fix => "a fixed bike")]}

    it 'should call the fix method on its bikes' do
    	broken_bike2 = double(:broken_bike2)
      subject.take([broken_bike,broken_bike2],van)
    	expect(broken_bike).to receive(:fix)
      expect(broken_bike2).to receive(:fix)
      subject.fix_bikes
    end

    it 'updates its bikes array with the results of #fix on each bike' do
      subject.take(broken_bikes_2,van)
      subject.fix_bikes
      expect(subject.bikes).to eq ["a fixed bike","a fixed bike"]
    end
  end

  context '#give_up' do
    let(:working_bike) {double(:working_bike,:broken? => false)}
    let(:broken_bike) {double(:broken_bike,:broken? => true)}
    let(:mixed_bikes) {[working_bike,broken_bike]}
    
    it 'should make the van take its working bikes' do
      subject.take(mixed_bikes,van)
      subject.give_up(van)
      expect(van).to have_received(:take).with([working_bike],subject)
    end
  end

  context '#update_stock' do
    let(:working_bike) {double(:working_bike,:broken? => false)}
    let(:broken_bike) {double(:broken_bike,:broken? => true)}
    let(:mixed_bikes) {[working_bike,broken_bike]}

    it 'should empty itself of working bikes and add the bikes in the array given to it' do
      subject.take(mixed_bikes,van)
      subject.update_stock([working_bike,working_bike])
      expect(subject.bikes).to eq [broken_bike,working_bike,working_bike]
    end
  end

end