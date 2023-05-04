class BaseCommon
    attr_reader :errors
    def initialize
      @errors = []
    end

    def check_record(record)
      @errors << record.errors if record.errors.present?
    end

    def call
      raise "Must be implemented in inheriting class"
    end

    def model
        raise NotImplementedError, 'model method must be implemented in child class'
    end
  
    def successful?
      @errors.blank?
    end
  end