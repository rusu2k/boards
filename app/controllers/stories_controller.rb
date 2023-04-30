class StoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :get_board
    before_action :get_story
    
    def index
        authorize Story
        
        service = Stories::StoriesCollector.new(@board, current_user) # storyCollector
        stories = service.call
        presenter = Stories::StoriesPresenter.new(@current_user) 
        stories = presenter.call(@board, stories)
        if service.successful? && presenter.successful?
            render json: stories, status: :ok
        else
            render json: { errors: service.errors + presenter.errors }, status: :bad_request
        end    
    end
    
    def show
        authorize Story

        presenter = Stories::StoryPresenter.new(current_user).call(params[:id]) 
        if presenter.successful? 
            render json: presenter.render, status: :ok # verific
        else
            render json: { errors: presenter.errors }, status: :not_found
        end
    end
    
    def create
        authorize Story

        service = Stories::Creator.new(@board)
        result = service.call(story_params)

        presenter = Stories::StoryPresenter.new(current_user)
        presenter.call(result&.id)

        if service.successful? && presenter.successful?
            render json: presenter.render, status: :created
        else
            render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
        end
    end
    
    def update
        authorize Story

        service = Stories::Updater.new(current_user)
        result = service.call(params[:id], story_params)

        

        presenter = Stories::StoryPresenter.new(current_user)
        presenter.call(result&.id)

        if service.successful? && presenter.successful?
            render json: presenter.render, status: :accepted
        else
            render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
        end
    end

    def destroy
        authorize Story

        service = Stories::Destroyer.new(current_user)
        result = service.call(params[:id])

        if service.successful?
            render json: { message: 'Story Deleted.' }, status: :ok
        else
            render json: { errors: service.errors }, status: :unprocessable_entity
        end
    end

    def assign
        authorize Story

        service = Stories::Assigner.new(current_user, @story)
        result = service.call(params[:user_id])
        
    
        if service.successful?
            render json: { message: 'Story assigned.' }, status: :ok
        else
            render json: { errors: service.errors }, status: :unprocessable_entity
        end
    end

    def advance
        authorize Story

        service = Stories::Updater.new(current_user)
        result = service.advance(params[:id])

        presenter = Stories::StoryPresenter.new(current_user)
        presenter.call(result&.id)

        if service.successful? && presenter.successful?
            render json: presenter.render, status: :accepted
        else
            render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
        end
    end

    def revert
        authorize Story

        service = Stories::Updater.new(current_user)
        result = service.revert(params[:id])

        presenter = Stories::StoryPresenter.new(current_user)
        presenter.call(result&.id)

        if service.successful? && presenter.successful?
            render json: presenter.render, status: :accepted
        else
            render json: { errors: service.errors + presenter.errors }, status: :unprocessable_entity
        end
    end

    private

    def story_params
        params.require(:story).permit(
            :title,
            :details,
            :due_date
        )
    end

    def get_board
        @board = Board.find_by(id: params[:board_id])
    end

    def get_story
        @story = Story.find_by(id: params[:id])
    end
end
