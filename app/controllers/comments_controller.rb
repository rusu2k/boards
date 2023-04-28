class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_story

  def index
    service = Comments::CommentsCollector.new(@story, current_user)
    comments = service.call

    presenter = Comments::CommentsPresenter.new(current_user)
    comments = presenter.call(comments, @story)

    if service.successful? && presenter.successful?
      render json: comments, status: :ok
    else
      render json: { errors: service.errors + presenter.errors }, status: :bad_request
    end   
  end

  def update
    service = Comments::Updater.new(current_user)
    result = service.call(params[:id], comment_params)

    presenter = Comments::CommentPresenter.new(current_user)
    presenter.call(result&.id)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :accepted
    else
        render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end
  end

  def show
    presenter = Comments::CommentPresenter.new(current_user).call(params[:id]) 
        if presenter.successful? 
            render json: presenter.render, status: :ok # verific
        else
            render json: { errors: presenter.errors }, status: :not_found
        end
  end

  def create
    service = Comments::Creator.new(current_user)
    result = service.call(@story, comment_params)

    presenter = Comments::CommentPresenter.new(current_user)
    presenter.call(result&.id)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :created
    else
        render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    service = Comments::Destroyer.new(current_user)
        result = service.call(params[:id])

        if service.successful?
            render json: { message: 'Comment Deleted.' }, status: :ok
        else
            render json: { errors: service.errors }, status: :unprocessable_entity
        end
  end

  private
  def comment_params
    params.require(:comment).permit(
      :content
    )
  end

  def get_story
    @story = Story.find_by(id: params[:story_id])
  end
end
