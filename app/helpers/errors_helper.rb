module ErrorsHelper
    attr_reader :errors

    def check_errors_for(record)
        @errors << record.errors if record.errors.present?
    end

    def init_errors
        @errors = []
    end

    def has_errors?
        @errors.present?
    end

end