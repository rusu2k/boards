class Boards::BoardPresenter
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end

    def call(board_id)
        @errors = []
        @board = load_board(board_id)
        check_board(@board)

        self
    end

    def check_board(board)
        @errors << "board could not be found in DB" unless board.present?
        @errors << "board not accessible" if !has_subscription?(board)
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

    def has_subscription?(board)
        BoardSubscription.exists?(user_id: @current_user.id, board_id: board.id) unless board.blank?
    end

    def successful?
        @errors.blank?
    end

  end