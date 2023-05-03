class Stories::ColumnChanger
    attr_reader :errors

    # Cache max and min position
    def initialize(stories_updater: Stories::Updater)
        @stories_updater = stories_updater
    end
    # APELEZ UPDATERU

    def call(story, advance: true)
        @errors = []
        @story = story
        check_story(story)
        
        return next_column if advance
        previous_column
    end

    def next_column
        @errors = []
        current_position = @story.column.position
        @errors << "The story is not advanceable" unless Column.exists?(position: current_position + 1)

        return if !successful?
        new_column = Column.find_by(position: current_position + 1)
        @stories_updater.call()
        @story.update(column_id: new_column.id)

        @story if successful?
    end

    def previous_column
        @errors = []
        current_position = @story.column.position
        @errors << "The story is not revertable" unless Column.exists?(position: current_position - 1)

        return if !successful?
        new_column = Column.find_by(position: current_position - 1)
        @story.update(column_id: new_column.id)

        @story if successful?
    end

    def check_story(story)
        @errors << "story could not be found in DB" unless story.present?
    end

    def successful?
        @errors.blank?
    end
end