class Boards::Filter < BaseFilter
  def run(options: {})
    return Board.all if options.blank?

    find_boards_by_user(options[:user])
  end

  def find_boards_by_user(user)
    return Board.none if user.blank? || user.id.blank?

    board_ids = subscriptions_for_user(user.id).map(&:board_id)
    return Board.none if board_ids.blank?

    Board.find(board_ids)
  end

  def subscriptions_for_user(user_id)
    BoardSubscription.where(user_id:)
  end
end
