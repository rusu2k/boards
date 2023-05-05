namespace :example_task do
    desc 'Retrieving archived stories'

    task retrieve_archived_stories: :environment do
        archived_stories = Story.where(side_status: "Archived").map do |story|
            "Story #{story.title} with id #{story.id} has been deployed at #{story.delivered_at} and has a side status of #{story.side_status}"
        end
        puts archived_stories
    end

    task retrieve_unasigned_stories: :environment do
        unasigned_stories = Story.where(user_id: nil)
        puts "Unassigned stories(ids): #{unasigned_stories.map(&:id)}"
    end
end

