class Boards::BoardsCollector < BaseCollector
    include Boards::CommonHelper

    def initialize(current_user)
        @current_user = current_user
    end
  
    def call
        super

        @boards = []
        
        subscriptions = find_subscriptions_by_user
        load_boards(subscriptions)
    end

    def load_boards(subscriptions)
        @errors << "no boards" unless subscriptions.present?
        return if !successful?
        
        subscriptions.each do |subscription|
            @boards << @collection.where(id: subscription.board_id).first
        end

        @boards
    end

    def find_subscriptions_by_user
        BoardSubscription.where(user: @current_user)
    end

end