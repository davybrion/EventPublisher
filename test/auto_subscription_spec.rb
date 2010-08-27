require_relative './publisher'
require 'spec'

describe EventPublisher, ": auto subscribing" do
	before(:each) do
	  @publisher = Publisher.new
	  @publisher.subscribe_all self
	end

	def first_event_handler(args);end
	def second_event_handler(arg1, arg2);end
	def some_other_handler(args);end
	
	it "should subscribe all suitable methods" do
		first_handler_subscribed = @publisher.subscribed? :first_event, method(:first_event_handler)
		second_handler_subscribed = @publisher.subscribed? :second_event, method(:second_event_handler)
		first_handler_subscribed.should be_true
		second_handler_subscribed.should be_true
	end
	
	it "should not subscribe unsuitable methods" do
		non_event_handler_subscribed_to_first_event = @publisher.subscribed? :first_event, method(:some_other_handler)
		non_event_handler_subscribed_to_second_event = @publisher.subscribed? :second_event, method(:some_other_handler)
		non_event_handler_subscribed_to_first_event.should be_false
		non_event_handler_subscribed_to_second_event.should be_false
	end
	
end
