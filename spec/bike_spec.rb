require 'bike'

describe Bike do

   context '#report_broken' do
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

   context '#fix' do
      it 'should stop the bike being broken' do
         subject.report_broken
         subject.fix
         expect(subject.broken?).to eq false
      end

      it 'should return the bike after it fixes it' do
         expect(subject.fix).to eq subject
      end
   end

end
