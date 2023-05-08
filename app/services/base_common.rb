class BaseCommon
  include ErrorsHelper

  def call(*args, **kwargs)
    before_run
    result = run(*args, **kwargs)
    after_run
    result
  end

  def before_run
    init_errors
  end

  def run
    raise NotImplementedError, 'Must be implemented in inheriting class'
  end

  def model # layer superior -> helper -> baseupdater,destroyer,creator
    raise NotImplementedError, 'model method must be implemented in child class'
  end

  def after_run; end

  def successful?
    !has_errors?
  end
end
