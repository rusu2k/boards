class Boards::BoardPresenter
    attr_reader :errors

    def call(board_id)
        @errors = []
        @board = load_board(board_id)
        check_board(@board)

        self
    end

    def check_board(board)
        @errors << "board could not be found in DB" unless board.present?
    end

    def load_board(board_id)
        @errors << "missing board id" unless board_id.present?
        return unless successful?
        Board.find_by(id: board_id)
    end
  
    def render
        {
            id: @board.id,
            title: @board.title
        }
    end

    def successful?
        @errors.blank?
    end

  end