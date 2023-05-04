class BaseUpdater < BaseCommon

    def run(record, params)
      @record = record

      @errors << "#{model.name} nott found" if @record.blank?
      @errors << "Update attributes missing" if params.blank?
      
      return if !successful?
      update_model(params)
    end
  
    def update_model(params)
      success = @record.update(params)
      return @record if success
      
      check_errors_for(@record)
      return
    end

end