class Users::UserPresenter
    def initialize(user)
        @user = user
    end


    # gresit -> facut pe 4 nivele, render pe USERS, nu pe boards, filtrare boards pt users
    # User -> Boards -> columns/stories/
    def render
        boards = []
        @user.boards.includes(:stories).map do |board|
            boards << { 
                "id": board.id,
                "name": board.title,
                "stories": board.stories.map do |story|
                    story = Stories::StoryPresenter.new.call(story).render
                end
             }
        end
        { boards: boards }
    end
end