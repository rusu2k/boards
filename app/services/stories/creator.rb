class Stories::Creator < BaseCreator
    include Stories::CommonHelper

    def initialize(board)
        @board = board
    end

    def call(params)
        puts params
        params[:board_id] = @board.id
        puts params
        super
    end

end