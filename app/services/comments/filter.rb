class Comments::Filter < BaseFilter
  def run(options: {})
    return Comment.all if options.blank?

    result = Comment
    # By default we get all the comments for the current story
    result = result.where(story_id: options[:story].id)

    result = result.where(user_id: options[:user_id]) if options.key?(:user_id)

    result
  end
end
