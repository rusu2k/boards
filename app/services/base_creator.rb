class BaseCreator < BaseCommon

    def run(params, **extras)
      @errors << "Update attributes missing" if params.blank?
      return if !successful?

      fix_params(params, extras) if extras.present?

      save_record(params)
    end

    def save_record(params)
      record = model.new(params)
      check_errors_for(record)

      return if !successful?
      
      record.save
      check_errors_for(record)

      return record if successful?

      return
    end

  end