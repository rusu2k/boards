class Columns::ColumnPresenter < BasePresenter
  include Columns::CommonHelper

  def render
    {
      id: @record.id,
      title: @record.title,
      position: @record.position
    }
  end
end
