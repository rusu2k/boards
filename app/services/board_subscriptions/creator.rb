class BoardSubscriptions::Creator
  include BaseCreator

  def initialize(board)
    @board = board
  end

  def call(params)
    @errors = []

    check_board
    check_params(params)
    return false if !successful?
    
    record = @board.board_subscriptions.build(params)
    save_record(record)
    
  end

  def check_board
    @errors << "board not found" if @board.blank? || !Board.exists?(id: @board.id)
  end

  def check_params(params)
      @errors << "user not found" if !User.exists?(id: params[:user_id])
  end

  def model
      BoardSubscription
  end


end