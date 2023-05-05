class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_story
  before_action :get_comment, only: [:show, :update, :destroy]

  def index
    authorize @story

    service = Comments::CommentsCollector.new(base_filter_service: Comments::Filter.new)
    comments = service.call( options: { story: @story } )

    presenter = Comments::CommentsPresenter.new
    comments = presenter.call(comments)

    if service.successful? && presenter.successful?
      render json: comments, status: :ok
    else
      render json: { errors: service.errors + presenter.errors }, status: :bad_request
    end   
  end

  def update
    authorize @comment

    service = Comments::Updater.new
    result = service.call(@comment, comment_params)

    presenter = Comments::CommentPresenter.new
    presenter.call(result)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :accepted
    else
        render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end
  end

  def show
    authorize @comment

    presenter = Comments::CommentPresenter.new.call(@comment) 
        if presenter.successful? 
            render json: presenter.render, status: :ok
        else
            render json: { errors: presenter.errors }, status: :not_found
        end
  end

  def create
    authorize @story

    service = Comments::Creator.new
    result = service.call(comment_params.merge(user_id: current_user.id, story_id: @story.id))

    presenter = Comments::CommentPresenter.new
    presenter.call(result)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :created
    else
        render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @comment
    
    service = Comments::Destroyer.new
        result = service.call(@comment)

        if service.successful?
            render json: { message: 'Comment Deleted.' }, status: :ok
        else
            render json: { errors: service.errors }, status: :unprocessable_entity
        end
  end

  private
  def comment_params
    params.require(:comment).permit(policy(Comment).permitted_attributes)
  end

  def get_story
    @story = Story.find_by(id: params[:story_id])
  end

  def get_comment
    @comment = Comment.find_by(id: params[:id])
  end
end
