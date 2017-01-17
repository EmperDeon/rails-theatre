# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env == 'production'
    Rails.logger = Le.new('dc1c6cbf-9eab-4b54-aaf2-80b307f48e50', :debug => true, :local => true)
end