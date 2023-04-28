class Boards::Creator
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end
  
    def call(params)
        @errors = []
        board = save_board(params)
        BoardSubscriptions::BoardSubscriptionsService.new(@current_user, board).create_subscription({"user_id": @current_user.id})
        board
    end

    def save_board(params)
        board = Board.new(params)
        check_board(board)
        return board if successful?
    end

    def check_board(board)
        @errors << board.errors unless board.save
    end

    def successful?
        @errors.blank?
    end
end