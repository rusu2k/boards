class BaseDestroyer < BaseCommon

    def run(record)
      @record = record

      @errors << "#{model.name} not found" if @record.blank?
      return if !successful?
      
      destroy_model
  
      @model
    end
  
    def destroy_model
      @record.destroy
      return @record if successful?

      check_record(@record)
    end
  
  end