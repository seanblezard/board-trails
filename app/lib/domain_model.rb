module DomainModel
	attr_accessor :id, :created_at, :updated_at, :violations

	def validate
		#Do nothing by default
	end

	def clear_violations
		@violations = []
	end

	def valid?
		true
	end

	def initialize(h={})
  	@@attributes_to_ignore=[:class, :type, :extra_errors, :queued_events, :errors, "type",  "class", "extra_errors", "queued_events", "errors"] # These won't get picked up in the automatic hash-based setters e.g. initialize(h) and attributes=(h) where h is the has of attributes and values
  	self.attributes=h
  	@violations = []
	end

	def attributes=(h) 
 		h.each {|k,v| send("#{k}=",v) unless !self.respond_to?(k) || @@attributes_to_ignore.include?(k)}
 	end

 	#
 	# If we try to do something that breaks the rules of our domain
 	#

 	class DomainViolation < Struct.new(:message)

 	end
end