require_relative '../lib/eventpublisher'

# this class is used as an example event publisher class by the tests
class Publisher
  include EventPublisher
  event :first_event
  event :second_event

  def trigger_first_event(args)
    trigger :first_event, args
  end

  def trigger_second_event(arg1, arg2)
    trigger :second_event, arg1, arg2
  end
end
