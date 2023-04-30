class BoardSubscriptionsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_board

    def create
        authorize BoardSubscription

        service = BoardSubscriptions::BoardSubscriptionsService.new(current_user, @board)
        result = service.create_subscription(board_subscriptions_params)

        # presenter
        
        if service.successful?
          render json: result, status: :created
        else
          render json: { error: service.errors }, status: :unprocessable_entity
        end
    end

    private
    def board_subscriptions_params
        params.require(:board_subscription).permit(:user_id)
    end

    def get_board
        @board = Board.find_by(id: params[:board_id])
    end
end
