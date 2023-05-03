class Stories::StoryPresenter < BasePresenter
    include Stories::CommonHelper
  
    def render
        {
            id: @record.id,
            title: @record.title,
            details: @record.details,
            due_date: @record.due_date,
            status: @record.column.title,
            user: @record.user_id,
            comments: Comments::CommentsPresenter.new.call(@record.comments)
        }
    end

  end