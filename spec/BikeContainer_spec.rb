require 'BikeContainer'
require 'Van'
require 'Garage'
require 'DockingStation'

shared_examples_for BikeContainer do
	let(:bike){ double(:bike) }
	let(:source){ spy(:source) }
	let(:workingbike){ double(:workingbike, broken?: false)}
	let(:brokenbike){ double(:brokenbike, broken?: true)}

	context '#take' do
		let(:destination){ described_class.new(3) }
		
		it 'should take as many bikes from the array given to it as it can' do
			destination.take([bike,bike,bike,bike],source)
			expect(destination.bikes).to eq [bike,bike,bike]
		end
		it 'should update the source with whatever bikes from the array it cannot take' do
			destination.take([bike,bike,bike,bike],source)
			expect(source).to have_received(:update_stock).with([bike])
		end
	end

	context '#update_stock' do
		it 'should empty itself of working bikes and take bikes given to it when #update_stock is passed with working bikes' do
		    subject.take([brokenbike,workingbike],source)
		    workingbike2 = double(:workingbike2, :broken? => false)
		    subject.update_stock([workingbike2])
		    expect(subject.bikes).to eq [brokenbike, workingbike2]
		end
		it 'should empty itself of broken bikes and take bikes given to it when #update_stock is passed with broken bikes' do
		    subject.take([brokenbike,workingbike],source)
		    brokenbike2 = double(:brokenbike2, :broken? => true)
		    subject.update_stock([brokenbike2])
		    expect(subject.bikes).to eq [workingbike, brokenbike2]
		end
    end

    context '#bikes' do
    	it 'should show the bikes are currently stored' do
    		subject.take([workingbike,workingbike,brokenbike,brokenbike],source)
    		[workingbike,workingbike,brokenbike,brokenbike].each do |bike|
				expect(subject.bikes).to include bike
			end
    	end
    end

end

describe Van do
	it_behaves_like BikeContainer
end

describe Garage do
	it_behaves_like BikeContainer
end

describe DockingStation do
	it_behaves_like BikeContainer
end