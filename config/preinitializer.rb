require 'yaml'
CHITO_CONFIG = YAML.load(File.read("#{RAILS_ROOT}/config/chito_config.yml"))
