class Stories::StoryPresenter
    attr_reader :errors

    def call(story_id)
        @errors = []
        @story = load_story(story_id)
        check_story(@story)

        self
    end

    def check_story(story)
        @errors << "story could not be found in DB" unless story.present?
    end

    def load_story(story_id)
        @errors << "missing story id" unless story_id.present?
        return unless successful?
        Story.find_by(id: story_id)
    end
  
    def render
        {
            id: @story.id,
            title: @story.title,
            details: @story.details,
            due_date: @story.due_date,
            status: @story.column.title,
            user: @story.user_id,
            comments: Comments::CommentsPresenter.new.call(@story.comments)
        }
    end

    def successful?
        @errors.blank?
    end

  end