require 'Van'

describe Van do

  let(:workingbike){double("workingbike", :broken? => false)}
  let(:brokenbike){double("brokenbike", :broken? => true)}

  let(:station){double("station", :give_up => nil, :take => nil )}
  let(:garage){double("garage", :give_up => nil, :take => nil )}

  let(:source){ double(:source, :update_stock => nil) }

  context 'when collecting bikes' do
    it 'should make the station or garage give up its broken bikes' do
      expect(station).to receive(:give_up).with(subject)
      subject.collect(station)
    end
  end

  context '#take' do
    let(:source){ double(:source, :update_stock => nil) }

    it 'should store as many of the bikes passed to it as will fit' do
      van = Van.new(3)
      van.take([brokenbike,brokenbike,brokenbike,brokenbike],source)
      expect(van.bikes).to eq [brokenbike,brokenbike,brokenbike]
    end

    it 'should make the source take back what it cannot fit' do
      van = Van.new(3)
      expect(source).to receive(:update_stock).with([brokenbike])
      van.take([brokenbike,brokenbike,brokenbike,brokenbike],source)
    end
  end

  context 'when delivering broken bikes to a garage' do
    it 'should make the garage take broken bikes' do
      subject.take([brokenbike,workingbike],source)
      expect(garage).to receive(:take).with([brokenbike],subject)
      subject.give_up_broken(garage)
    end

    it 'should empty itself of broken bikes and take bikes given to it when #update_stock is passed with broken bikes' do
      subject.take([brokenbike,workingbike],source)
      brokenbike2 = double(:brokenbike2, :broken? => true)
      subject.update_stock([brokenbike2])
      expect(subject.bikes).to eq [workingbike, brokenbike2]
    end
  end

  context 'when delivering working bikes to a station' do
    it 'should make the station take working bikes' do
      subject.take([brokenbike,workingbike],source)
      expect(station).to receive(:take).with([workingbike],subject)
      subject.give_up_working(station)
    end

    it 'should empty itself of working bikes and takes bikes given to it when #update_stock is passed with working bikes' do
      subject.take([brokenbike,workingbike],source)
      workingbike2 = double(:workingbike2, :broken? => false)
      subject.update_stock([workingbike2])
      expect(subject.bikes).to eq [brokenbike, workingbike2]
    end
  end

end