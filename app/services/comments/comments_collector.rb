class Comments::CommentsCollector < BaseCollector
include Comments::CommonHelper

    def initialize(story)
        @story = story
    end
  
    def run
        collect
        @comments = []
        
        check_errors_for_story
        return if !successful?

        @comments = @collection.where(story_id: @story.id)

        @comments
    end

    def check_errors_for_story
        @errors << 'Story not accesible' if @story.blank?
    end

end