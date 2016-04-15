require 'Van'

describe Van do

  let(:workingbike){double("workingbike", :broken? => false)}
  let(:brokenbike){double("brokenbike", :broken? => true)}
  let(:station){double("station", :bikes => [workingbike, brokenbike], :remove_broken_bikes => nil, :take => nil )}
  let(:garage){double("garage", :receive_broken => [brokenbike], :bikes => [workingbike, brokenbike], :remove_working_bikes => nil )}

  context 'when collecting broken bikes' do

    it 'should store broken bikes from station' do
      subject.collect_working(garage)
      subject.collect_broken(station)
      expect(subject.bikes).to eq [workingbike,brokenbike]
    end

    it 'should remove broken bikes from the station' do
      expect(station).to receive(:remove_broken_bikes)
      subject.collect_broken(station)
    end

  end

  context 'when delivering broken bikes' do

    it 'should empty itself of broken bikes' do
      subject.collect_broken(station)
      subject.collect_working(garage)
      subject.deliver_broken(garage)
      expect(subject.bikes.length).to eq 1
    end

    it 'should make the garage receive broken bikes' do
      subject.collect_broken(station)
      expect(garage).to receive(:receive_broken).with(subject.bikes)
      subject.deliver_broken(garage)
    end

  end

  context 'when collecting working bikes from the garage' do

    it 'should store working bikes from the garage' do
      subject.collect_broken(station)
      subject.collect_working(garage)
      expect(subject.bikes).to eq [brokenbike,workingbike]
    end

    it 'should remove working bikes from the garage' do
      expect(garage).to receive(:remove_working_bikes)
      subject.collect_working(garage)
    end

  end

  context 'when delivering working bikes to a station' do

    it 'makes the station take working bikes' do
      subject.collect_working(garage)
      subject.collect_broken(station)
      expect(station).to receive(:take).with([workingbike],subject)
      subject.deliver_working(station)
    end

    it 'empties itself of working bikes and takes bikes given to it with update stock' do
      workingbike2 = double(:workingbike2)
      subject.collect_working(garage)
      subject.collect_broken(station)
      subject.update_stock([workingbike2])
      expect(subject.bikes).to eq [brokenbike, workingbike2]
    end

  end


end