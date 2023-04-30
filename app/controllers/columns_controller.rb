class ColumnsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_board
    before_action :get_column, only: [:show, :update, :destroy]
  
    # def index
    #   authorize Column
    #   service = Columns::ColumnsCollector.new(@board, current_user)
    #   columns = service.call
  
    #   presenter = Columns::ColumnsPresenter.new(current_user)
    #   columns = presenter.call(columns)
  
    #   if service.successful? && presenter.successful?
    #     render json: columns, status: :ok
    #   else
    #     render json: { errors: service.errors + presenter.errors }, status: :bad_request
    #   end   
    # end
  
    # def create
    #   authorize Column
    #   service = Columns::Creator.new(current_user)
    #   result = service.call(@board, column_params)
  
    #   presenter = Columns::ColumnPresenter.new(current_user)
    #   presenter.call(result&.id)
  
    #   if service.successful? && presenter.successful?
    #       render json: presenter.render, status: :created
    #   else
    #       render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    #   end
    # end
  
    # def update
    #   authorize Column
    #   service = Columns::Updater.new(current_user)
    #   result = service.call(@column, column_params)
  
    #   presenter = Columns::ColumnPresenter.new(current_user)
    #   presenter.call(result&.id)
  
    #   if service.successful? && presenter.successful?
    #       render json: presenter.render, status: :accepted
    #   else
    #       render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    #   end
    # end
  
    # def show
    #   authorize Column
    #   presenter = Columns::ColumnPresenter.new(current_user).call(params[:id]) 
    #   if presenter.successful? 
    #     render json: presenter.render, status: :ok
    #   else
    #     render json: { errors: presenter.errors }, status: :not_found
    #   end
    # end
  
    # def destroy
    #   authorize Column
    #   service = Columns::Destroyer.new(current_user)
    #   result = service.call(@column)
  
    #   if service.successful?
    #     render json: { message: 'Column Deleted.' }, status: :ok
    #   else
    #     render json: { errors: service.errors }, status: :unprocessable_entity
    #   end
    # end
  
    # private
  
    # def column_params
    #   params.require(:column).permit(:title, :position)
    # end
  
    # def get_board
    #   @board = Board.find(params[:board_id])
    # end
  
    # def get_column
    #   @column = @board.columns.find(params[:id])
    # end
  end
  