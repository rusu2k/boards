class Boards::BoardPresenter < BasePresenter
  include Boards::CommonHelper

  def render
    {
      id: @record.id,
      title: @record.title
    }
  end
end
