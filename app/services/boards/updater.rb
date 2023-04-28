class Boards::Updater
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end
  
    def call(board_id, params)
        @errors = []
        @board = load_board(board_id)
        
        update_board(params)

    end

    def update_board(params)        
        @errors << @board.errors unless @board.update(title: params[:title])
        check_board(@board)
        return @board if successful?
    end

    def check_board(board)
        @errors << "boards could not be found in DB" unless board.present?
        @errors << "board not accessible" if @current_user.id.blank? # != board.user_id # daca permisiunile de pe board nu includ user_id logat
    end

    def load_board(board_id)
        @errors << "missing board id" unless board_id.present?
        return unless successful?
        Board.find_by(id: board_id)
    end

    def successful?
        @errors.blank?
    end
end