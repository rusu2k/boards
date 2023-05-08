class Comments::CommentPresenter < BasePresenter
  include Comments::CommonHelper

  def render
    {
      id: @record.id,
      content: @record.content,
      user_id: @record.user_id,
      story_id: @record.story_id
    }
  end
end
