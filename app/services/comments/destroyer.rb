
class Comments::Destroyer
    include BaseDestroyer

    private
  
    def model
      Comment
    end
end