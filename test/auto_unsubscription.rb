require './publisher'
require 'spec'

describe EventPublisher, ": auto unsubscribing" do
	before(:each) do
	  @publisher = Publisher.new
		@publisher.subscribe_all self
		@publisher.unsubscribe_all self
	end

	def first_event_handler(args);end
	def second_event_handler(arg1, arg2);end
	def some_other_handler(args);end
	
	it "should unsubscribe all suitable methods" do
		first_handler_subscribed = @publisher.subscribed? :first_event, method(:first_event_handler)
		second_handler_subscribed = @publisher.subscribed? :second_event, method(:second_event_handler)
		first_handler_subscribed.should == false
		second_handler_subscribed.should == false
	end
	
end