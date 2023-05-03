class BaseUpdater < BaseCommon
    attr_reader :errors

    def call(record, params)
      @errors = []
      @record = record

      @errors << "#{model.name} not found" if @record.blank?
      @errors << "Update attributes missing" if params.blank?
      

      return if !successful?
      update_model(params)
    end
  
    def update_model(params)
      success = @record.update(params)
      return @record if success
      
      check_record(@record)
      return
    end

  
  end