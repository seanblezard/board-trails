Dir.glob(File.join(File.dirname(__FILE__),'.','**.rb')).each do |file|
  require file
end

require_relative 'write/init'
require_relative 'read/init'
