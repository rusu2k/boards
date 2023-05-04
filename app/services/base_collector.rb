class BaseCollector < BaseCommon
  :collection

  def run
    collect
  end

  def collect
    @collection = model.all

    @errors << "Failed to collect #{model} records" if @collection.blank?
    @collection if successful?
  end

end