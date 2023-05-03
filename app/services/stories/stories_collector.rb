class Stories::StoriesCollector
    attr_reader :errors

    def initialize(board)
        @board = board
    end
  
    def call
        @errors = []
        @stories = []
        
        check_board
        @board.stories unless !successful?
    end

    def check_board
        @errors << 'Board not accesible' if @board.blank?
    end

    def successful?
        @errors.blank?
    end

end