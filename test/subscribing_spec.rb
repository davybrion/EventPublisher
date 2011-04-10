require_relative './publisher'
require 'rspec'

describe EventPublisher do
  
  context "subscribing" do
    
    before(:each) do
      @publisher = Publisher.new
    end

    def first_event_handler(args);end
    def second_event_handler(arg1, arg2);end

    it "should not know about a method that isn't subscribed" do
      subscribed = @publisher.subscribed? :first_event, method(:first_event_handler)
      subscribed.should be_false
    end

    it "should know about the subscribed method for the correct event" do
      @publisher.subscribe :first_event, method(:first_event_handler)
      subscribed = @publisher.subscribed? :first_event, method(:first_event_handler)
      subscribed.should be_true
    end

    it "should not know about a subscribed method for a different event" do
      @publisher.subscribe :first_event, method(:first_event_handler)
      subscribed = @publisher.subscribed? :second_event, method(:first_event_handler)
      subscribed.should be_false
    end

  end
  
end