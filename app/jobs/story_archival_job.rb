class StoryArchivalJob 
    include Sidekiq::Job

    def perform(*args)
        stories = Story.where.not(delivered_at: nil)
        stories = stories.where("delivered_at < ?", Time.now - 300)

        stories.each do |story|
            story.update(side_status: "Archived")
        end

        p "hello from StoryArchivalJob #{Time.now().strftime('%F - %H:%M:%S.%L')}"
    end

end