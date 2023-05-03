class Stories::StoriesPresenter
    attr_reader :errors

    def call(stories)
        @errors = []
        result = []

        return if !successful?
        story_presenter = Stories::StoryPresenter.new
        

        stories.each do |story|
            story_presenter.call(story)
            check_story_presenter(story_presenter)
            result << story_presenter.render
        end
        result
    end

    def check_story_presenter(story_presenter)
        @errors << story_presenter.errors unless story_presenter.successful?
    end
    
    def successful?
        @errors.blank?
    end
  end