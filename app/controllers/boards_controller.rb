class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_board, only: %i[show update destroy]

  # # GET /boards
  # swagger_controller :boards, "Boards Management"

  # # GET /boards
  # swagger_api :index do
  #   summary "Returns a list of boards"
  #   response :ok
  #   response :bad_request
  # end

  def index
    authorize Board
    service = Boards::BoardsCollector.new(base_filter_service: Boards::Filter.new)
    boards = service.call(options: { user: current_user })
    presenter = Boards::BoardsPresenter.new
    boards = presenter.call(boards)
    if service.successful? && presenter.successful?
      render json: boards, status: :ok
    else
      render json: { errors: service.errors + presenter.errors }, status: :bad_request
    end
  end

  # # GET /boards/:id
  # swagger_api :show do
  #   summary "Returns a board"
  #   param :path, :id, :integer, :required, "Board ID"
  #   response :ok
  #   response :not_found
  # end

  def show
    authorize @board
    presenter = Boards::BoardPresenter.new.call(@board)
    if presenter.successful?
      render json: presenter.render, status: :ok # verific
    else
      render json: { errors: presenter.errors }, status: :not_found
    end
  end

  # # POST /boards
  # swagger_api :create do
  #   summary "Creates a new board"
  #   param :form, :name, :string, :required, "Board Name"
  #   response :created
  #   response :unprocessable_entity
  # end

  def create
    authorize Board
    service = Boards::Creator.new

    board = service.call(board_params)
    BoardSubscriptions::Creator.new.call({ "user_id": current_user.id, board_id: board.id }) if board.present?
    presenter = Boards::BoardPresenter.new
    presenter.call(board)

    if service.successful? && presenter.successful?
      render json: presenter.render, status: :created
    else
      render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /boards/:id
  # swagger_api :update do
  #   summary "Updates a board"
  #   param :path, :id, :integer, :required, "Board ID"
  #   param :form, :name, :string, :optional, "Board Name"
  #   response :accepted
  #   response :unprocessable_entity
  # end

  def update
    authorize @board

    service = Boards::Updater.new
    board = service.call(@board, board_params)

    presenter = Boards::BoardPresenter.new
    presenter.call(board)

    if service.successful? && presenter.successful?
      render json: presenter.render, status: :accepted
    else
      render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end
  end

  # # DELETE /boards/:id
  # swagger_api :destroy do
  #   summary "Deletes a board"
  #   param :path, :id, :integer, :required, "Board ID"
  #   response :ok
  #   response :unprocessable_entity
  # end

  def destroy
    authorize @board
    service = Boards::Destroyer.new
    service.call(@board)

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
