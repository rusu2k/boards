class BasePresenter < BaseCommon

    def run(record)
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

end