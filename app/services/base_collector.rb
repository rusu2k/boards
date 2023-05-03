class BaseCollector
    attr_reader :errors, :collection
    
    def initialize
      
    end
  
    

    
    def successful?
      @errors.blank?
    end
  
  end