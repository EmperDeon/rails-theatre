# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Rails.logger = Le.new('dc1c6cbf-9eab-4b54-aaf2-80b307f48e50', :debug => true, :local => true)

Rails.logger.warn("Look at me, I'm a warning message")
Rails.logger.info("Look at me, I'm an info message")
Rails.logger.debug("Look at me, I'm a debug message")
