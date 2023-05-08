class BaseFilter < BaseCommon
  def run(options: {})
    model.all(options)
  end
end
