class Stories::Assigner
  attr_reader :errors

  def initialize(story)
    @story = story
  end

  def call(params)
    @errors = []
    check_story
    return false unless successful?

    check_user(params[:user_id])
    @story.update(user_id: params[:user_id]) if successful?
  end

  def check_user(user_id)
    @errors << 'user not found' unless User.exists?(id: user_id)
  end

  def check_story
    @errors << 'story not found' unless @story.is_a?(Story)
  end

  def successful?
    @errors.blank?
  end
end
