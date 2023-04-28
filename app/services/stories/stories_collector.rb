class Stories::StoriesCollector
    attr_reader :errors

    def initialize(board, current_user)
        @current_user = current_user
        @board = board
    end
  
    def call
        @errors = []
        @stories = []
        
        check_board
        @board.stories unless @board.blank?

        
    end

    def check_board
        @errors << 'Board not accesible' if @board.blank?
    end

    def successful?
        @errors.blank?
    end

end