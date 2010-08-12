# Load the rails application
require File.expand_path('../application', __FILE__)

require "chito_helper"
require "chito_version"
require "chito_routes"

CHITO_CONFIG = YAML.load(File.read("#{Rails.root}/config/chito_config.yml"))
# Initialize the rails application
Chito::Application.initialize!
