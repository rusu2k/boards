require 'rails_helper'

RSpec.describe BaseCollector do
  let(:filtered_collection) { double('FilteredCollection') }
  subject { described_class.new }

  before do
    allow_any_instance_of(BaseFilter).to receive(:run).and_return(filtered_collection)
    subject.instance_variable_set(:@errors, [])
    allow(subject).to receive(:model).and_return('model')
  end

  describe '#run' do
    context 'when collection is not blank' do
      it 'returns the filtered collection' do
        expect(subject.run(options: {foo: 'bar'})).to eq(filtered_collection)
      end

      it 'sets @collection to the filtered collection' do
        subject.run(options: {foo: 'bar'})
        expect(subject.collection).to eq(filtered_collection)
      end

      it 'does not add any errors to @errors' do
        subject.run(options: {foo: 'bar'})
        expect(subject.errors).to be_empty
      end
    end

  end
end
