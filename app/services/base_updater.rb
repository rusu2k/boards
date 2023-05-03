class BaseUpdater < BaseCommon
    attr_reader :errors


    # instanta de board/story/, nu id !!!!!!!!!!!!!!!
    def call(model, params)
      @errors = []
      @model = model
  
      update_model(params)
    end
  
    def update_model(params)
      # model exista? params exista? !!!!!!
      @errors << @model.errors unless @model.update(params)
  
      check_model(@model)
      return @model if successful?
    end
  
    def check_model(model)
      @errors << "#{model} could not be found in DB" unless model.present?
    end
  
    def successful?
      @errors.blank?
    end
  
    private
  
    def model
        raise NotImplementedError, 'model method must be implemented in child class'
    end
  
  end