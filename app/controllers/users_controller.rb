class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    presenter = Users::UserPresenter.new(current_user)
    render json: presenter.render, status: :ok
  end
end
