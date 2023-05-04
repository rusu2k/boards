class Stories::StoriesCollector < BaseCollector
    include Stories::CommonHelper

    def initialize(board)
        @board = board
    end
  
    def run
        collect
        @stories = []
        
        check_errors_for_board
        return if !successful?

        @stories = @collection.where(board_id: @board.id)
        
        @stories
    end

    def check_errors_for_board
        @errors << 'Board not found' if @board.blank?
    end

end