require "yaml"
require_relative "lib/connector.rb"

app_config = YAML::load_file(File.join(__dir__, '/config/app.yml'))

connector = Connector.new(app_config)
connector.get_user_token
connector.get_servers
connector.register_server

puts app_config

