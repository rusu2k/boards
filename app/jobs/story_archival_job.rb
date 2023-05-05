class StoryArchivalJob < ApplicationJob
    queue_as :default

    def perform(*args)
        sleep 5

        p "hello from StoryArchivalJob #{Time.now().strftime('%F - %H:%M:%S.%L')}"
    end

end