class Comments::Creator < BaseCreator
    include Comments::CommonHelper

    def initialize(user, story)
        @user = user
        @story = story
    end
  
    def call(params)
        params[:story_id] = @story.id
        params[:user_id] = @user.id
        super
    end
end