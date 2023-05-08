class Stories::ColumnChanger
  attr_reader :errors

  # Cache max and min position
  def initialize(stories_updater: Stories::Updater)
    @stories_updater = stories_updater.new
  end

  def call(story, advance)
    @errors = []
    @story = story
    check_story(story)

    return unless successful?

    return next_column if advance

    previous_column
  end

  def next_column
    @errors = []
    current_position = @story.column.position
    @errors << 'The story is not advanceable' unless Column.exists?(position: current_position + 1)

    return unless successful?

    new_column = Column.find_by(position: current_position + 1)
    @stories_updater.call(@story, { column_id: new_column.id })

    @errors += @stories_updater.errors unless @stories_updater.successful?

    @stories_updater.call(@story, { delivered_at: Time.now }) if @story.column_id == Story::DEPLOYED_COLUMN
    @story if successful?
  end

  def previous_column
    @errors = []
    current_position = @story.column.position
    @errors << 'The story is not revertable' unless Column.exists?(position: current_position - 1)

    return unless successful?

    new_column = Column.find_by(position: current_position - 1)
    @stories_updater.call(@story, { column_id: new_column.id })

    @errors += @stories_updater.errors unless @stories_updater.successful?

    @story if successful?
  end

  def check_story(story)
    @errors << 'story could not be found in DB' unless story.present?
  end

  def successful?
    @errors.blank?
  end
end
