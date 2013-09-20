module DomainModel
	attr_accessor :id, :created_at, :updated_at, :violations

	def validate
	end

	def clear_violations
		@violations = []
	end

	def valid?
		@violations.size == 0		
	end

	def initialize(attributes={})
  	self.attributes=attributes
  	@violations = []
	end

	def attributes=(attributes) 
 		attributes.each {|attribute_key,attribute_value| send("#{attribute_key}=",attribute_value) unless !self.respond_to?(attribute_key)}
 	end

 	#
 	# If we try to do something that breaks the rules of our domain
 	#

 	class DomainViolation < Struct.new(:message)

 	end
end