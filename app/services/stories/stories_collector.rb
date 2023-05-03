class Stories::StoriesCollector < BaseCollector
    include Stories::CommonHelper

    def initialize(board)
        @board = board
    end
  
    def call
        super
        @stories = []
        
        check_board
        return if !successful?

        @stories = @collection.where(board_id: @board.id)
        
        @stories
    end

    def check_board
        @errors << 'Board not found' if @board.blank?
    end

end