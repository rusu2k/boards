class Stories::StoriesPresenter
    attr_reader :errors

    def initialize(current_user)
        @current_user = current_user
    end


    def call(board, stories)
        @errors = []
        result = []
        check_board(board)

        return if !successful?
        story_presenter = Stories::StoryPresenter.new(@current_user)
        

        stories.each do |story|
            story_presenter.call(story.id)
            check_story_presenter(story_presenter)
            result << story_presenter.render
        end
        result
    end

    def check_board(board)
        @errors << "Board not found" unless board.present?
    end

    def check_story_presenter(story_presenter)
        @errors << story_presenter.errors unless story_presenter.successful?
    end
    
    def successful?
        @errors.blank?
    end
  end