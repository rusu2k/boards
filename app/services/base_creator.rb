class BaseCreator < BaseCommon
    attr_reader :errors

  
    def call(params)
      @errors = []

      @errors << "Update attributes missing" if params.blank?
      return if !successful?

      save_record(params)
    end

    def save_record(params)
      record = model.new(params)
      check_record(record)

      return if !successful?
      
      record.save
      check_record(record)

      return record if successful?

      return
    end

  end