class Comments::Creator
    include BaseCreator

    def initialize(user)
        @user = user
    end
  
    def call(story, params)
        @errors = []
        record = story.comments.build(params.merge(user_id: @user.id))
        save_record(record)
    end

    def model
        Comment
    end
end