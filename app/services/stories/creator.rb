class Stories::Creator < BaseCreator

    def initialize(board)
        @board = board
    end

    def call(params)
        @errors = []
        record = @board.stories.build(params)
        save_record(record)
    end

    def model
        Story
    end
end