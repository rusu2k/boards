class Comments::Updater
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end
  
    def call(comment_id, params)
        @errors = []
        @comment = load_comment(comment_id)
        
        check_permission
        update_comment(params) if successful?
    end

    def update_comment(params)      
          
        @errors << @comment.errors unless @comment.update(content: params[:content])
        
        check_comment(@comment)
        return @comment if successful?
    end

    def check_comment(comment)
        @errors << "comment could not be found in DB" unless comment.present?
        
    end

    def check_permission
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