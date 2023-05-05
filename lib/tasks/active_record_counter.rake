namespace :active_record_counter do
  desc "Display the count of board model"
  task boards_count: :environment do
    puts "Boards Count = #{Board.count}"
  end

  desc "Display the count of story model"
  task stories_count: :environment do
    puts "Stories Count = #{Story.count}"
  end

  desc "Display the count of comment model"
  task comments_count: :environment do
    puts "Comments Count = #{Comment.count}"
  end

  desc "Display the count of user model"
  task users_count: :environment do
    puts "Users Count = #{User.count}"
  end

  desc "Display the count of column model"
  task columns_count: :environment do
    puts "Column Count = #{Column.count}"
  end

  desc "Display the count of board subscriptions model"
  task board_subscriptions_count: :environment do
    puts "Board Subscriptions Count = #{BoardSubscription.count}"
  end

end
