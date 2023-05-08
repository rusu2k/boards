class BaseCollector < BaseCommon
  attr_reader :collection

  def initialize(base_filter_service: BaseFilter.new)
    
    @base_filter_service = base_filter_service
  end

  def run(options: {})
    @collection = @base_filter_service.run(options:)

    @errors << "Failed to collect #{model} records" unless @base_filter_service.successful?
    return unless successful?

    @collection
  end
end
