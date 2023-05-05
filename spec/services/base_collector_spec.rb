require 'rails_helper'

RSpec.describe BaseCollector do
    
    let(:filtered_collection) { double('FilteredCollection') }
    subject { described_class.new }
  
      before do
        allow_any_instance_of(BaseFilter).to receive(:run).and_return(filtered_collection)
        subject.instance_variable_set(:@errors, [])
        allow(subject).to receive(:model).and_return("model")
      end
  
    describe '#run' do
      context 'when collection is not blank' do
        it 'returns the filtered collection' do
          expect(subject.run(foo: "bar")).to eq(filtered_collection)
        end
  
        it 'sets @collection to the filtered collection' do
          subject.run(foo: "bar")
          expect(subject.collection).to eq(filtered_collection)
        end
  
        it 'does not add any errors to @errors' do
          subject.run(foo: "bar")
          expect(subject.errors).to be_empty
        end
      end

      context 'when collection is blank' do
        before do
          allow(filtered_collection).to receive(:blank?).and_return(true)
        end
  
        it 'returns nil' do
          expect(subject.run(foo: "bar")).to be_nil
        end
  
        it 'sets @errors with an error message' do
          
          subject.run(foo: "bar")
          expect(subject.errors).to include("Failed to collect #{subject.model} records")
        end
      end
    end
  end