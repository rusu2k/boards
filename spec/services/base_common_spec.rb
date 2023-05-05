require 'rails_helper'

RSpec.describe BaseCommon do
  describe '#call' do
    it 'calls before_run and run methods' do
      instance = BaseCommon.new
      expect(instance).to receive(:before_run)
      expect { instance.call }.to raise_error(NotImplementedError)
    end
  end

  describe '#before_run' do
    it 'initializes errors' do
      instance = BaseCommon.new
      instance.before_run
      expect(instance.instance_variable_get(:@errors)).to eq([])
    end
  end

  describe '#run' do
    it 'raises NotImplementedError' do
      instance = BaseCommon.new
      expect { instance.run }.to raise_error(NotImplementedError)
    end
  end

  describe '#model' do
    it 'raises NotImplementedError' do
      instance = BaseCommon.new
      expect { instance.model }.to raise_error(NotImplementedError)
    end
  end

  describe '#successful?' do
    context 'when there are no errors' do
      it 'returns true' do
        instance = BaseCommon.new
        instance.instance_variable_set(:@errors, [])
        expect(instance.successful?).to eq(true)
      end
    end

    context 'when there are errors' do
      it 'returns false' do
        instance = BaseCommon.new
        instance.instance_variable_set(:@errors, { message: 'Model not found' })
        expect(instance.successful?).to eq(false)
      end
    end
  end
end