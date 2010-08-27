require './publisher'
require 'spec'

describe EventPublisher, ": unsubscribing" do
	before(:each) do
	  @publisher = Publisher.new
	end

	def first_event_handler(args);end

	it "should no longer know about an unsubscribed method for the correct event" do
		@publisher.subscribe :first_event, method(:first_event_handler)
		@publisher.unsubscribe :first_event, method(:first_event_handler)
		subscribed = @publisher.subscribed? :first_event, method(:first_event_handler)
		subscribed.should == false
	end
	
end