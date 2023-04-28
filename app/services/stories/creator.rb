class Stories::Creator
    attr_reader :errors

    def initialize(board)
        @board = board
    end
  
    def call(params)
        @errors = []
        check_board
        return if !successful?
        save_story(params)
    end

    def save_story(params)
        
        story = @board.stories.create(params)
        check_story(story)
        return story if successful?
    end

    def check_board
        @errors << "Board not accessible" unless @board.present?
    end

    def check_story(story)
        @errors << story.errors if story.errors.present?
    end

    def successful?
        @errors.blank?
    end
end