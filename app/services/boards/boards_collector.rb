class Boards::BoardsCollector
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end
  
    def call
        @errors = []
        @boards = []
        subscriptions = find_subscriptions_by_user
        load_boards(subscriptions)
        
    end

    def load_boards(subscriptions)
        @errors << "no boards" unless subscriptions.present?
        subscriptions.each do |subscription|
            @boards << Board.find_by(id: subscription.board_id)
        end
        @boards
    end

    def find_subscriptions_by_user
        BoardSubscription.where(user: @current_user)
    end

    def successful?
        @errors.blank?
    end

end