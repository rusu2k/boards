class ColumnsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_column, only: [:show, :update, :destroy]
  
    def index
      authorize Column
      service = Columns::ColumnsCollector.new
      columns = service.call
  
      presenter = Columns::ColumnsPresenter.new
      columns = presenter.call(columns)
  
      if service.successful? && presenter.successful?
        render json: columns, status: :ok
      else
        render json: { errors: service.errors + presenter.errors }, status: :bad_request
      end   
    end
  
    def create
      authorize Column
      service = Columns::Creator.new
      result = service.call(column_params)
  
      presenter = Columns::ColumnPresenter.new
      presenter.call(result)
  
      if service.successful? && presenter.successful?
          render json: presenter.render, status: :created
      else
          render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
      end
    end
  
    def update
      authorize Column
      service = Columns::Updater.new
      result = service.call(@column, column_params)
  
      presenter = Columns::ColumnPresenter.new
      presenter.call(result)
  
      if service.successful? && presenter.successful?
          render json: presenter.render, status: :accepted
      else
          render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
      end
    end
  
    def show
      authorize @column
      presenter = Columns::ColumnPresenter.new.call(@column) 
      if presenter.successful? 
        render json: presenter.render, status: :ok
      else
        render json: { errors: presenter.errors }, status: :not_found
      end
    end
  
    def destroy
      authorize Column
      service = Columns::Destroyer.new
      result = service.call(@column)
  
      if service.successful?
        render json: { message: 'Column Deleted.' }, status: :ok
      else
        render json: { errors: service.errors }, status: :unprocessable_entity
      end
    end
  
  private

  def column_params
    params.require(:column).permit(policy(Column).permitted_attributes)
  end

  def get_column
    @column = Column.find_by(id: params[:id])
  end

end
  