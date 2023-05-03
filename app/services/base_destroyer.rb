class BaseDestroyer
    attr_reader :errors

    # model in loc de id
    def call(model_id)
      @errors = []
      @model = load_model(model_id)
  
      destroy_model
  
      @model
    end
  
    def destroy_model
      check_model(@model)
      @model.destroy
      return @model if successful?
    end
  
    def check_model(model)
      @errors << "#{model} could not be found in DB" unless model.present?
    end
  
    def load_model(model_id)
      @errors << "missing #{model} id" unless model_id.present?
      return unless successful?
      model.find_by(id: model_id)
    end
  
    def successful?
      @errors.blank?
    end
  
    private
  
    def model
      raise NotImplementedError, 'model method must be implemented in child class'
    end
  
  end