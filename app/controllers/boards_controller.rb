class BoardsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_board, only: [:show, :update, :destroy]
    
  def index
    authorize Board
    service = Boards::BoardsCollector.new(current_user) # BoardCollector
    boards = service.call
    presenter = Boards::BoardsPresenter.new
    boards = presenter.call(boards)
    if service.successful? && presenter.successful?
        render json: boards, status: :ok
    else
      render json: { errors: service.errors + presenter.errors }, status: :bad_request
    end
  end
  
  def show
    authorize @board
    presenter = Boards::BoardPresenter.new.call(params[:id]) 
    if presenter.successful? 
        render json: presenter.render, status: :ok # verific
    else
        render json: { errors: presenter.errors }, status: :not_found
    end
  end
  
  def create
    authorize Board
    service = Boards::Creator.new

    board = service.call(board_params)
    BoardSubscriptions::Creator.new(board).call({"user_id": current_user.id})
    
    presenter = Boards::BoardPresenter.new
    presenter.call(board.id)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :created
    else
      render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end

  end
  
  def update
    authorize @board

    service = Boards::Updater.new
    board = service.call(params[:id], board_params)

    presenter = Boards::BoardPresenter.new
    presenter.call(board.id)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :accepted
    else
      render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end

  end

  def destroy
    authorize @board
    service = Boards::Destroyer.new
    service.call(params[:id])

    if service.successful?
        render json: { message: 'Board Deleted.' }, status: :ok
    else
        render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  private
  def board_params
    params.require(:board).permit(policy(Board).permitted_attributes)
  end

  def get_board
    @board = Board.find_by(id: params[:id])
  end
  

end
