require 'rails_helper'

RSpec.describe BaseCommon do
  subject { described_class.new }
  describe '#call' do
    it 'calls before_run and run methods' do
      #instance = BaseCommon.new
      expect(subject).to receive(:before_run)
      expect { subject.call }.to raise_error(NotImplementedError)
    end

    it 'calls after_run and returns result' do
      allow(subject).to receive(:run).and_return("result")
      expect(subject).to receive(:after_run)
      subject.call
      expect(subject).to receive(:call).and_return("result")
      subject.call
    end
  end

  describe '#before_run' do
    it 'initializes errors' do
      #subject = BaseCommon.new
      subject.before_run
      expect(subject.instance_variable_get(:@errors)).to eq([])
    end
  end

  describe '#run' do
    it 'raises NotImplementedError' do
      #instance = BaseCommon.new
      expect { subject.run }.to raise_error(NotImplementedError)
    end
  end

  describe '#model' do
    it 'raises NotImplementedError' do
      #instance = BaseCommon.new
      expect { subject.model }.to raise_error(NotImplementedError)
    end
  end

  describe '#successful?' do
    context 'check for errors' do
      it 'returns true when there are no errors' do
        #instance = BaseCommon.new
        subject.instance_variable_set(:@errors, [])
        expect(subject.successful?).to eq(true)
      end

      it 'returns false when there is atleast one error' do
        #instance = BaseCommon.new
        subject.instance_variable_set(:@errors, { message: 'Model not found' })
        expect(subject.successful?).to eq(false)
      end
    end
  end
end
