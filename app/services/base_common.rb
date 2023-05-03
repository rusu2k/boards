class BaseCommon
    attr_reader :errors
  
    def check_record(record)
      @errors << record.errors if record.errors.present?
    end

    def model
        raise NotImplementedError, 'model method must be implemented in child class'
    end
  
    def successful?
      @errors.blank?
    end
  end