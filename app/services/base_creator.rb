class BaseCreator < BaseCommon

    def run(params)
      @errors << "Update attributes missing" if params.blank?
      return if !successful?

      save_record(params)
    end



    def save_record(params)
      record = model.new
      record.assign_attributes(params)
      
      record.save
      check_errors_for(record)

      return if !successful?
      
      record
    end

  end