class BaseCollector
  attr_reader :errors, :collection
    
  def call
    @errors = []
    
    @collection = model.all
    @collection = @collection.where()

  end

  end