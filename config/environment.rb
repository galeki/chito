# Load the rails application
require File.expand_path('../application', __FILE__)

require "chito_helper"
require "chito_version"
require "chito_routes"

# Initialize the rails application
Chito::Application.initialize!
