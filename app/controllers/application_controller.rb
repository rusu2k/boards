class ApplicationController < ActionController::API
    include ActionController::MimeResponds

    respond_to :json

    def after_sign_in_path_for scope
        root_path
    end

    
end
