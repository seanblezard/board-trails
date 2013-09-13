require 'uuidtools'

module MemoryRepository

	# A simple hash of objects keyed on a unique id
	@@memory={}

	# Persistence for the Board domain model
	class BoardRepository
		def domain_class
			Board
		end

		def new(attributes={})
			domain = domain_class.new(attributes)			
			domain
		end

		def create(domain)
			MemoryRepository.memory ||= {}
			
			domain.validate
			
			if domain.valid?
				domain.created_at = Time.now.utc
				domain.id=MemoryRepository.issue_new_id
				MemoryRepository.memory[domain.id] = domain
			end

			domain
		end

		def update(domain)
			MemoryRepository.memory ||= {}
			
			domain.validate			
			
			if domain.valid?
				domain.updated_at = Time.now.utc
				MemoryRepository.memory[domain.id] = domain
			end
			
			domain
		end		

		def all()
			MemoryRepository.all_by_class(self.domain_class)
		end
	end




	def self.issue_new_id
		UUIDTools::UUID.random_create.to_s 
	end

	def self.all_by_class(domain_class)
		MemoryRepository.memory ||= {}
		results = []
		@@memory.each do |key, value|
			results << value if value.class == domain_class
		end
		results
	end

	def self.memory
		@@memory
	end

	def self.clear_memory
		@@memory={}
	end
end