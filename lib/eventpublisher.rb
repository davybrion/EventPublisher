module EventPublisher
	class Event
		attr_reader :name

		def initialize(name)
			@name = name
			@handlers = []
		end

		def add(method=nil, &block)
			@handlers << method if method
			@handlers << block if block
		end

		def has?(method)
			@handlers.include? method
		end

		def remove(method)
			@handlers.delete method if method
		end

		def trigger(*args)
			@handlers.each { |handler| handler.call *args }
		end	
	end	

	def subscribe_all(subscriber)
		each_suitable_handler(subscriber) do |event_symbol, method_symbol|
			subscribe event_symbol, subscriber.method(method_symbol)
		end
	end
	
	def unsubscribe_all(subscriber)
		each_suitable_handler(subscriber) do |event_symbol, method_symbol|
			unsubscribe event_symbol, subscriber.method(method_symbol)
		end
	end
	
	def subscribe(symbol, method=nil, &block)
		event = send(symbol)
		event.add method if method
		event.add block if block
	end

	def unsubscribe(symbol, method)
		event = send(symbol)
		event.remove method
	end

	def subscribed?(symbol, method)
		event = send(symbol)
		event.has? method
	end

	private
	
	def each_suitable_handler(subscriber)
		possible_handlers = subscriber.class.instance_methods.select { |name| name =~ /\w_handler/ }
		possible_handlers.each do |method_name|
			event_name = /(?<event_name>.*)_handler/.match(method_name)[:event_name]	
			if EVENTS.include? event_name.to_sym
				yield event_name.to_sym, method_name.to_sym
			end
		end
	end
	
	def trigger(symbol, *args)
		event = send(symbol)
		event.trigger *args
	end
	
	self.class.class_eval do
		EVENTS = []

		def event(symbol)
			getter = symbol
			variable = :"@#{symbol}"
			EVENTS << symbol

			define_method getter do
				if !instance_variable_defined? variable
					event = Event.new(symbol.to_s)
					instance_variable_set variable, event
				end
				
				instance_variable_get variable
			end
			
			private getter
		end
	end
end

