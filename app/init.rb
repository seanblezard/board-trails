Dir.glob(File.join(File.dirname(__FILE__),'.','**.rb')).each do |file|
  require file
end

require_relative 'lib/init'
require_relative 'domain/init'
require_relative 'controllers/init'
require_relative 'repositories/init'
