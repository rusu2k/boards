class StoryArchivalJob
  include Sidekiq::Job
  sidekiq_options retry: 10, retry_queue: 'low'
  
  DELIVERED_START_TIME = 5.minutes.ago

  def perform(*args)
    stories = Story.where.not(delivered_at: nil)
    stories = stories.where('delivered_at < ?', DELIVERED_START_TIME)

    stories.find_each do |story|
      story.update(side_status: 'Archived')
    end

    # metoda 2 : update fara a incarca modelul - tradeoff - avantaje si dezavantaje pt fiecare

  end


end
