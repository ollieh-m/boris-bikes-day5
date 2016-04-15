require 'bike'

describe Bike do

   it 'responds to working?' do	
	expect(Bike.new).to respond_to :working?
   end

   it { is_expected.to respond_to :report_broken }
   it { is_expected.to respond_to :broken? }

   describe '#report_broken' do
   	it 'should give the bike a broken attribute' do
   		expect(subject.broken?).to eq false
   		subject.report_broken
   		expect(subject.broken?).to eq true
   	end
   	it 'should set the bike to not working' do
   		expect(subject.working?).to eq true
   		subject.report_broken
   		expect(subject.working?).to eq false
   	end
   end

   it 'fixes bikes' do
      subject.report_broken
      subject.fix
      expect(subject.broken?).to eq false
   end

   it 'returns bike after it fixes bike' do
      expect(subject.fix).to eq subject
   end
   
end
