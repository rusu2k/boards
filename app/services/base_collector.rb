class BaseCollector < BaseCommon
  attr_reader :errors, :collection
    
  def call
    @errors = []
    
    @collection = model.all

    @errors << "Failed to collect #{model} records" if @collection.blank?
    @collection if successful?
  end

  end