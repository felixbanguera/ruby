require "yaml"
require_relative "lib/reporter.rb"
require_relative "lib/connector.rb"

app_config = YAML::load_file(File.join(__dir__, '/config/app.yml'))

puts app_config

reporter = Reporter.new#(app_config['os'])
connector = Connector.new#(app_config)

puts reporter.get_data