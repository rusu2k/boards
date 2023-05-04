class BoardSubscriptionsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_board, only: [:create]

    def create
        authorize @board

        service = BoardSubscriptions::Creator.new
        result = service.call(board_subscriptions_params, board: @board)

        # presenter
        
        if service.successful?
          render json: result, status: :created
        else
          render json: { error: service.errors }, status: :unprocessable_entity
        end
    end

    private
    def board_subscriptions_params
        params.require(:board_subscription).permit(policy(BoardSubscription).permitted_attributes)
    end

    def get_board
        @board = Board.find_by(id: params[:board_id])
    end
end
