class BaseUpdater < BaseCommon
  def run(record, params)
    return unless record.present?

    @record = record

    @errors << 'Update attributes missing' if params.blank?

    return unless successful?

    update_model(params)
  end

  def update_model(params)
    success = @record.update(params)
    return @record if success

    check_errors_for(@record)
  end
end
