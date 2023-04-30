class ApplicationController < ActionController::API
    include ActionController::MimeResponds
    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    respond_to :json

    private

    def user_not_authorized
        render json: { error: "Not authorized" }, status: :unauthorized 
    end
end
