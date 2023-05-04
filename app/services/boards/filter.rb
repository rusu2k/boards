class Boards::Filter < BaseFilter
    def run(options: {})
        return Board.all if options.blank?
        find_boards_by_user(options[:user])
    end

    def find_boards_by_user(user)
        boards = []
        subscriptions = BoardSubscription.where(user_id: user.id)
        
        subscriptions.each do |subscription|
            boards << Board.find_by(id: subscription.board_id)
        end

        boards
    end
end