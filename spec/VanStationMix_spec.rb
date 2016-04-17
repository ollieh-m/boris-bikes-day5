require 'VanStationMix'
require 'Van'
require 'DockingStation'

shared_examples_for VanStationMix do
	let(:brokenbike){ double(:brokenbike, broken?: true ) }
	let(:workingbike){ double(:workingbike, broken?: false) }
	let(:destination){ spy(:desintation) }
	let(:source){ spy(:source) }
	
	context '#give_up_broken' do
		it 'should make the destination take broken bikes' do
      		subject.take([brokenbike,workingbike],source)
		    subject.give_up_broken(destination)
		    expect(destination).to have_received(:take).with([brokenbike],subject)
		end	    
    end
end

describe Van do
	it_behaves_like VanStationMix
end

describe DockingStation do
	it_behaves_like VanStationMix
end