class Comments::Creator < BaseCreator
    include Comments::CommonHelper

    def fix_params(params, extras)
        params[:user_id] = extras[:user].id
        params[:story_id] = extras[:story].id
    end
end