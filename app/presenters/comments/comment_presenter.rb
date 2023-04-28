class Comments::CommentPresenter
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end

    def call(comment_id)
        @errors = []
        @comment = load_comment(comment_id)
        check_comment

        self
    end

    def check_comment
        @errors << "comment could not be found in DB" unless @comment.present?
    end

    def load_comment(comment_id)
        @errors << "missing comment id" unless comment_id.present?
        return unless successful?
        Comment.find_by(id: comment_id)
    end
  
    def render
        {
            id: @comment.id,
            content: @comment.content,
            user_id: @comment.user_id,
            story_id: @comment.story_id
        }
    end

    def successful?
        @errors.blank?
    end

  end