class BoardSubscriptions::Creator < BaseCreator
  include BoardSubscriptions::CommonHelper

  def fix_params(params, extras)
    params[:board_id] = extras[:board].id
  end

end