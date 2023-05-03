class Stories::Creator < BaseCreator
    include Stories::CommonHelper

    def initialize(board)
        @board = board
    end

    def call(params)
        params[:board_id] = @board.id
        super
    end

end