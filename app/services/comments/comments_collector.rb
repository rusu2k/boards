class Comments::CommentsCollector
    attr_reader :errors

    def initialize(story)
        @story = story
    end
  
    def call
        @errors = []
        @comments = []
        
        check_story
        @story.comments unless !successful?
    end

    def check_story
        @errors << 'Story not accesible' if @story.blank?
    end

    def successful?
        @errors.blank?
    end

end