class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_story
  before_action :get_comment, only: [:show, :update, :destroy]

  def index
    authorize @story

    service = Comments::CommentsCollector.new(@story)
    comments = service.call

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
    result = service.call(params[:id], comment_params)

    presenter = Comments::CommentPresenter.new
    presenter.call(result&.id)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :accepted
    else
        render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end
  end

  def show
    puts @comment.inspect
    authorize @comment

    presenter = Comments::CommentPresenter.new.call(params[:id]) 
        if presenter.successful? 
            render json: presenter.render, status: :ok # verific
        else
            render json: { errors: presenter.errors }, status: :not_found
        end
  end

  def create
    authorize @story

    service = Comments::Creator.new(current_user)
    result = service.call(@story, comment_params)

    presenter = Comments::CommentPresenter.new
    presenter.call(result&.id)

    if service.successful? && presenter.successful?
        render json: presenter.render, status: :created
    else
        render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @comment
    
    service = Comments::Destroyer.new
        result = service.call(params[:id])

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
