class Comments::Creator
    attr_reader :errors

    def initialize(user)
        @current_user = user
    end
  
    def call(story, params)
        @errors = []
        @story = story
        save_comment(params)

    end

    def save_comment(params)
        check_story
        return if !successful?
        comment = @story.comments.create(params.merge(user_id: @current_user.id, story_id: @story.id))
        check_comment(comment)
        return comment if successful?
    end

    def check_story
        @errors << "Story not accessible" unless @story.present?
    end

    def check_comment(comment)
        @errors << comment.errors if comment.errors.present?
    end

    def successful?
        @errors.blank?
    end
end