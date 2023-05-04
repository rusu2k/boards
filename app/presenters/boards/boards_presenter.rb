class Boards::BoardsPresenter
    attr_reader :errors

    def call(boards)
        board_presenter = Boards::BoardPresenter.new
        @errors = []
        result = []

        boards.each do |board|
            board_presenter.call(board)
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