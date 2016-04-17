require 'Van'
require 'Garage'
require 'VanGarageMix'

shared_examples_for VanGarageMix do
	let(:workingbike){ double(:workingbike, broken?: false) }
	let(:brokenbike){ double(:brokenbike, broken?: true) }
	let(:destination){ spy(:desintation) }
	let(:source){ spy(:source) }

	context '#give_up_working' do
		it 'should make destination take its working bikes' do
			subject.take([workingbike,brokenbike],source)
			subject.give_up_working(destination)
			expect(destination).to have_received(:take).with([workingbike],subject)
		end
	end
end

describe Van do
	it_behaves_like VanGarageMix
end

describe Garage do
	it_behaves_like VanGarageMix
end