require 'rails_helper'

RSpec.describe BaseFilter do
    describe '#run' do
      it 'calls model.all with the given options' do
        mock_model = double('MockModel')
        options = { param1: 'value1', param2: 'value2' }
        instance = BaseFilter.new
  
        # Stub model method to return the mock_model
        allow(instance).to receive(:model).and_return(mock_model)
  
        # Expect model.all to be called with the given options
        expect(mock_model).to receive(:all).with(options)
  
        instance.run(options: options)
      end
    end
  end