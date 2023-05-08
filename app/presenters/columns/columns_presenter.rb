class Columns::ColumnsPresenter
  attr_reader :errors

  def call(columns)
    column_presenter = Columns::ColumnPresenter.new
    @errors = []
    result = []
    @errors << 'No columns found' if columns.blank?

    return [] unless successful?

    columns.each do |column|
      column_presenter.call(column)
      check_column_presenter(column_presenter)
      result << column_presenter.render
    end
    result
  end

  def check_column_presenter(column_presenter)
    @errors << column_presenter.errors unless column_presenter.successful?
  end

  def successful?
    @errors.blank?
  end
end
