class Comments::CommentsPresenter
  attr_reader :errors

  def call(comments)
    @errors = []
    result = []

    @errors << 'No comments found' if comments.blank?

    return unless successful?

    comment_presenter = Comments::CommentPresenter.new

    comments.each do |comment|
      comment_presenter.call(comment)
      check_comment_presenter(comment_presenter)
      result << comment_presenter.render
    end
    result
  end

  def check_comment_presenter(comment_presenter)
    @errors << comment_presenter.errors unless comment_presenter.successful?
  end

  def successful?
    @errors.blank?
  end
end
