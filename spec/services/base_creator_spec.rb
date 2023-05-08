require 'rails_helper'

RSpec.describe BaseCreator do
  subject { described_class.new }

  describe '#run' do
    let(:params) { { name: 'Board 1' } }
    let(:model) { double('Model') }
    let(:record) { double('Record') }

    before do
      allow(subject).to receive(:model).and_return(model)
      allow(model).to receive(:new).and_return(record)
      subject.instance_variable_set(:@errors, [])
      allow(record).to receive(:assign_attributes).with(params)

    end

    context 'when params are not blank' do
      it 'calls save_record with the params' do
        expect(subject).to receive(:save_record).with(params)
        subject.run(params)
      end

      it 'does not add any errors to the @errors attribute' do
        allow(record).to receive(:errors).and_return([])
        allow(record).to receive(:assign_attributes).with(params)
        allow(record).to receive(:save)
        subject.run(params)
        expect(subject.errors).to be_empty
      end
    end

    context 'when params are blank' do
      before do
        allow(params).to receive(:blank?).and_return(true)
      end

      it 'does not call save_record' do
        expect(subject).not_to receive(:save_record)
        subject.run(params)
      end

      it 'adds an error message to the @errors attribute' do
        subject.run(params)
        expect(subject.errors).to include('Update attributes missing')
      end
    end
  end

  describe '#save_record' do
    let(:params) { { name: 'Board 1' } }
    let(:model) { double('Model') }
    let(:record) { double('Record') }

    before do
      allow(subject).to receive(:model).and_return(model)
      allow(model).to receive(:new).and_return(record)
      subject.instance_variable_set(:@errors, [])
      allow(record).to receive(:assign_attributes).with(params)

    end

    context 'when record saves successfully' do
      before do
        allow(record).to receive(:save).and_return(true)
        allow(record).to receive(:errors).and_return([])
      end

      it 'calls check_errors_for with the record' do
        expect(subject).to receive(:check_errors_for).with(record)
        allow(record).to receive(:assign_attributes).with(params)
        subject.save_record(params)
      end

      it 'returns the record' do
        expect(subject.save_record(params)).to eq(record)
        allow(record).to receive(:assign_attributes).with(params)

      end
    end

    context 'when record fails to save' do
      before do
        allow(record).to receive(:assign_attributes).with(params)
        allow(record).to receive(:save).and_return(false)
      end

      it 'calls check_errors_for with the record' do
        expect(subject).to receive(:check_errors_for).with(record)
        subject.save_record(params)
      end

      it 'does not return the record' do
        allow(record).to receive(:errors).and_return(["error"])
        expect(subject.save_record(params)).to be_nil
        subject.save_record(params)
        
      end
    end
  end
end
