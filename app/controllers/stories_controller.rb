class StoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :get_board
    before_action :get_story, only: [:show, :update, :destroy, :assign, :next_column, :previous_column]
    
    def index
        authorize @board
        
        service = Stories::StoriesCollector.new(@board) # storyCollector
        stories = service.call
        presenter = Stories::StoriesPresenter.new 
        stories = presenter.call(stories)
        if service.successful? && presenter.successful?
            render json: stories, status: :ok
        else
            render json: { errors: service.errors + presenter.errors }, status: :bad_request
        end    
    end
    
    def show
        authorize @story if @story.present?

        presenter = Stories::StoryPresenter.new.call(@story) 
        if presenter.successful? 
            render json: presenter.render, status: :ok # verific
        else
            render json: { errors: presenter.errors }, status: :not_found
        end
    end
    
    def create
        authorize @board

        service = Stories::Creator.new(@board)
        result = service.call(story_params)

        presenter = Stories::StoryPresenter.new
        presenter.call(result)

        if service.successful? && presenter.successful?
            render json: presenter.render, status: :created
        else
            render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
        end
    end
    
    def update
        authorize @story

        service = Stories::Updater.new
        result = service.call(@story, story_params)

        presenter = Stories::StoryPresenter.new
        presenter.call(result)

        if service.successful? && presenter.successful?
            render json: presenter.render, status: :accepted
        else
            render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
        end
    end

    def destroy
        authorize @story

        service = Stories::Destroyer.new
        result = service.call(@story)

        if service.successful?
            render json: { message: 'Story Deleted.' }, status: :ok
        else
            render json: { errors: service.errors }, status: :unprocessable_entity
        end
    end

    def assign
        authorize @story

        service = Stories::Assigner.new(@story)
        result = service.call(story_params_assign)
        
    
        if service.successful?
            render json: { message: 'Story assigned.' }, status: :ok
        else
            render json: { errors: service.errors }, status: :unprocessable_entity
        end
    end

    def next_column
        authorize @story

        service = Stories::ColumnChanger.new
        result = service.call(@story, true)

        presenter = Stories::StoryPresenter.new
        presenter.call(result)

        if service.successful? && presenter.successful?
            render json: presenter.render, status: :accepted
        else
            render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
        end
    end

    def previous_column
        authorize @story

        service = Stories::ColumnChanger.new
        result = service.call(@story, false)

        presenter = Stories::StoryPresenter.new
        presenter.call(result)

        if service.successful? && presenter.successful?
            render json: presenter.render, status: :accepted
        else
            render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
        end
    end

    private

    def story_params
        params.require(:story).permit(policy(Story).permitted_attributes)
    end

    def story_params_assign
        params.require(:story).permit(policy(@story).permitted_attributes_for_assign)
    end

    def get_board
        @board = Board.find_by(id: params[:board_id])
    end

    def get_story
        @story = Story.find_by(id: params[:id])
    end
end
