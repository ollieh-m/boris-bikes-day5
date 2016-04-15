require 'DockingStation'

describe DockingStation do
        let(:bikedouble){ double("bike", :working? => true, :broken? => false) }
        let(:broken_bike){ double("brokenbike", :broken? => true) }
        let(:van){ spy(:van) }
        let(:docking_station) do
            subject.dock(bikedouble)
            subject.dock(broken_bike)
            subject
        end

    context 'when releasing a bike' do
        it 'should successfully release working bike if one is available' do
            expect(docking_station.release_bike).to be_working
        end

        it 'should remove the released bike' do
            docking_station.release_bike
            expect(docking_station.bikes).to eq [broken_bike]
        end

        it 'should raise an error if attempting to release bike from an empty station' do
            expect{subject.release_bike}.to raise_error 'No bikes available'
        end

        it 'should raise an error if no working bike is available' do
            subject.dock(broken_bike)
            expect{subject.release_bike}.to raise_error 'No working bikes available'
        end
    end

    context 'when docking a bike' do
        it 'should successfully dock a working bike' do
            subject.dock(bikedouble)
            expect(subject.bikes).to eq [bikedouble]
        end

        it 'should successfully dock a broken bike' do
            subject.dock(broken_bike)
            expect(subject.bikes).to include broken_bike
        end

        it 'should allow 45 bikes to be docked when 45 is set as the capacity' do
            docking_station = DockingStation.new(45)
            45.times{docking_station.dock(bikedouble)}
            expect(docking_station.bikes.length).to eq 45
        end

        it 'should raise an error when exceding DEFAULT_CAPACITY when no custom capacity is given' do
            DockingStation::DEFAULT_CAPACITY.times{ subject.dock bikedouble }
            expect{ subject.dock bikedouble }.to raise_error 'Dock already full'
        end

        it 'should raise an error when exceding Capacity when a custom capacity is given' do
            docking_station = DockingStation.new(75)
            75.times{docking_station.dock(bikedouble)}
            expect{docking_station.dock(bikedouble)}.to raise_error 'Dock already full'
        end
    end

    context '#remove_broken_bikes' do
        it 'should remove broken bikes' do
            docking_station.remove_broken_bikes
            expect(docking_station.bikes).not_to include broken_bike
        end
    end

    context '#take' do
        let(:docking_station) do
            station = DockingStation.new(3)
            station.dock(bikedouble)
            station
        end

        it 'should take as many bikes as it can from the array provided' do
            docking_station.take([bikedouble,bikedouble,bikedouble,bikedouble],van)
            expect(docking_station.bikes.length).to eq 3
        end

        it 'should update the van\'s stock with the bikes it can\'t take' do
            docking_station.take([bikedouble,bikedouble,bikedouble,bikedouble],van)
            expect(van).to have_received(:update_stock).with([bikedouble,bikedouble])
        end
    end

end

