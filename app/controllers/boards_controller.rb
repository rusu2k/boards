class BoardsController < ApplicationController
    before_action :authenticate_user!
    
  def index
    authorize Board
    service = Boards::BoardsCollector.new(current_user) # BoardCollector
    boards = service.call
    presenter = Boards::BoardsPresenter.new(current_user)
    boards = presenter.call(boards)
    if service.successful? && presenter.successful?
        render json: boards, status: :ok
    else
      render json: { errors: service.errors + presenter.errors }, status: :bad_request
    end
    
  end
  
  def show
    authorize Board
    presenter = Boards::BoardPresenter.new(current_user).call(params[:id]) 
    if presenter.successful? 
        render json: presenter.render, status: :ok # verific
    else
        render json: { errors: presenter.errors }, status: :not_found
    end
  end
  
  def create
    authorize Board
    service = Boards::Creator.new(current_user)

    board = service.call(board_params)
    
    presenter = Boards::BoardPresenter.new(current_user)
    presenter.call(board.id)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :created
    else
      render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end

  end
  
  def update
    authorize Board

    service = Boards::Updater.new(current_user)
    board = service.call(params[:id], board_params)

    presenter = Boards::BoardPresenter.new(current_user)
    presenter.call(board.id)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :accepted
    else
      render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end

  end

  def destroy
    authorize Board
    service = Boards::Destroyer.new(current_user)
    service.call(params[:id])

    if service.successful?
        render json: { message: 'Board Deleted.' }, status: :ok
    else
        render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  private
  def board_params
    params.require(:board).permit(  # permit - important security feature : makes so that it accepts only the specified number of parameters
      :title)
  end
  

end
