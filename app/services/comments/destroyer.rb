class Comments::Destroyer
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end
  
    def call(comment_id)
        @errors = []
        @comment = load_comment(comment_id)
        
        destroy_comment

    end

    def destroy_comment        
        check_comment(@comment)
        return unless successful?

        @comment.destroy
        return @comment if successful?
    end

    def check_comment(comment)
        @errors << "comments could not be found in DB" unless comment.present?
        @errors << "comment not accessible" if @current_user.id != @comment.user_id
    end

    def load_comment(comment_id)
        @errors << "missing comment id" unless comment_id.present?
        return unless successful?
        Comment.find_by(id: comment_id)
    end

    def successful?
        @errors.blank?
    end

end