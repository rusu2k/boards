class Comments::CommentsPresenter
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end


    def call(comments, story)
        @errors = []
        result = []
        check_story(story)

        return if !successful?
        comment_presenter = Comments::CommentPresenter.new(@current_user)
        
        comments.each do |comment|
            comment_presenter.call(comment.id)
            check_comment_presenter(comment_presenter)
            result << comment_presenter.render
        end
        result
    end

    def check_story(story)
        @errors << "Story not found" unless story.present?
    end

    def check_comment_presenter(comment_presenter)
        @errors << comment_presenter.errors unless comment_presenter.successful?
    end
    
    def successful?
        @errors.blank?
    end
  end