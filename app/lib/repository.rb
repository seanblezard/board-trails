class Repository
	def self.register (type, repo)
		repositories[type] = repo
	end

	def self.repositories
		@@repositories ||= {}
	end

	def self.for(type)
		self.repositories[type]
	end
end