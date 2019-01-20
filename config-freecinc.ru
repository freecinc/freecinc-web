require './freecinc'

require 'logger'

# Patching the Logger class so that it knows how to write
# see https://github.com/customink/stoplight/issues/14
class ::Logger
  alias_method :write, :<<
end

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG
logger.info('Starting up')

use Rack::CommonLogger, logger

run Sinatra::Application
