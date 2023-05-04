class BasePresenter
    # baseCommon
    attr_reader :errors

    def call(record)
        puts record
        @errors = []
        @record = record
        check_record

        self
    end

    def render
        "Must be implemented in inheriting class" 
    end

    def check_record
        @errors << "#{model} could not be found in DB" if @record.blank?
    end

    def model
        raise "Must be implemented in inheriting class"
    end

    def successful?
        @errors.blank?
    end

end