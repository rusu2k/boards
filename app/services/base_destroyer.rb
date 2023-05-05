class BaseDestroyer < BaseCommon

    def run(record)
      return if record.blank?
      
      @record = record
      
      destroy_model
    end
  
    def destroy_model
      success = @record.destroy
      return @record if success

      check_errors_for(@record)
    end
  
  end