
class Stories::Destroyer
    include BaseDestroyer

    private
  
    def model
      Story
    end
end