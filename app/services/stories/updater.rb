class Stories::Updater
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end
  
    def call(story_id, params)
        @errors = []
        @story = load_story(story_id)
        
        update_story(params)
    end

    def update_story(params)        
        @errors << @story.errors unless @story.update(title: params[:title], details: params[:details], due_date: params[:due_date])
        
        check_story(@story)
        return @story if successful?
    end

    def check_story(story)
        @errors << "story could not be found in DB" unless story.present?
        @errors << "story not accessible" if @current_user.id.blank? # != board.user_id # daca permisiunile de pe board nu includ user_id logat
    end

    def load_story(story_id)
        @errors << "missing story id" unless story_id.present?
        return unless successful?
        Story.find_by(id: story_id)
    end

    def successful?
        @errors.blank?
    end
end