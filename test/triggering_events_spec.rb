require_relative './publisher'
require 'spec'

describe EventPublisher, ": triggering event" do
	before(:each) do
	  @publisher = Publisher.new
	end

	it "should not fail without any subscribers" do
	  @publisher.trigger_first_event "testing"
	end

	it "should pass single event arg correctly to subscribed method with one argument" do
		@args = nil
		def first_event_handler(args);
			@args = args
		end

		@publisher.subscribe :first_event, method(:first_event_handler)
		@publisher.trigger_first_event "testing!"
		@args.should == "testing!"
	end
	
	it "should pass multiple event args correctly to subscribed method with multiple arguments" do
		@args2_1, @args2_2 = nil, nil
		def second_event_handler(arg1, arg2)
			@args2_1, @args2_2 = arg1, arg2
		end
		
		@publisher.subscribe :second_event, method(:second_event_handler)
		@publisher.trigger_second_event "second", "event"
		@args2_1.should eql("second")
		@args2_2.should eql("event")
	end

	it "should pass single event arg correctly to subscribed block with one argument" do
		event_args = nil
		@publisher.subscribe(:first_event) { |args| event_args = args }
		@publisher.trigger_first_event "test"
	  event_args.should eql("test")
	end
	
	it "should pass multiple event args correctly to subscribed block with two arguments" do
	  first_arg, second_arg = nil, nil
		@publisher.subscribe(:second_event) { |arg1,arg2| first_arg, second_arg = arg1, arg2 }
		@publisher.trigger_second_event "first", "second"
		first_arg.should eql("first")
		second_arg.should eql("second")
	end
	
	it "should call subscribed method once for each time it was subscribed" do
	  @counter1 = 0
		def first_event_handler(args)
			@counter1 += 1
		end
		
		2.times { @publisher.subscribe :first_event, method(:first_event_handler) }
		@publisher.trigger_first_event "test"
		@counter1.should == 2
	end
	
	it "should call all subscribed methods" do
		@counter1, @counter2 = 0, 0
		def handler1(args)
			@counter1 += 1
		end
		
		def handler2(args)
			@counter2 += 1
		end
		
		@publisher.subscribe :first_event, method(:handler1)
		@publisher.subscribe :first_event, method(:handler2)
		@publisher.trigger_first_event "first_event"
		@counter1.should eql(1)
		@counter2.should eql(1)
	end
	
end
