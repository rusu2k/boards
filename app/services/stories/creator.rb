class Stories::Creator < BaseCreator
    include Stories::CommonHelper

    def fix_params(params, extras)
        params[:board_id] = extras[:board].id
    end
end