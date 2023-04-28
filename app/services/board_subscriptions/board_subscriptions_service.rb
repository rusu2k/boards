class BoardSubscriptions::BoardSubscriptionsService
    attr_reader :errors

    def initialize(user, board)
      @current_user = user
      @board = board
    end
  
    def create_subscription(params)
      @errors = []
      #board = Board.find_by(id: @board.id)
      
      check_board
      return false if !successful?
      check_params(params)
      return false if !successful?
      
      board_subscription = @board.board_subscriptions.build(user_id: params[:user_id], board_id: @board.id)
  
      if board_subscription.save
        return board_subscription #BoardSubscriptionPresenter.new(board_subscription)?
      else
        @errors << board_subscription.errors
      end
    end

    def check_board
        @errors << "board not found" if @board.blank?
    end

    def check_params(params)
        @errors << "user not found" if !User.exists?(id: params[:user_id])
        @errors << "board not found" if !Board.exists?(id: @board.id)
    end

    def successful?
        @errors.blank?
    end
    
end