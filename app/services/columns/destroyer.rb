
class Columns::Destroyer
    include BaseDestroyer

    private
  
    def model
      Column
    end
end