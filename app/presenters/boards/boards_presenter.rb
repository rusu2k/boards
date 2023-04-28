class Boards::BoardsPresenter
    def initialize(current_user)
        @current_user = current_user
    end


    def call(boards)
        board_presenter = Boards::BoardPresenter.new(@current_user)
        @errors = []
        result = []

        boards.each do |board|
            board_presenter.call(board.id)
            check_board_presenter(board_presenter)
            result << board_presenter.render
        end
        result
    end

    def check_board_presenter(board_presenter)
        @errors << board_presenter.errors unless board_presenter.successful?
    end
    
    def successful?
        @errors.blank?
    end
  end