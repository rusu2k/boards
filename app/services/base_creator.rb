class BaseCreator
    attr_reader :errors

  
    def call(params)
      @errors = []
      record = model.new(params)
      save_record(record)
    end

  
    def save_record(record)
      check_record(record)
      return record if !successful?
      record.save
      check_record(record)
      record
    end
  
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