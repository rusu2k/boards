class Columns::Filter < BaseFilter
  def run(options: {})
    return Column.all if options.blank?
  end
end
