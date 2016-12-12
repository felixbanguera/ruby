require "yaml"
class Connector
  def initialize(app_config)
    #app_config = YAML::load_file(File.join(__dir__, '../config/app.yml'))
    @server_id = app_config['server_id']
    @server_ip = app_config['server_ip']
    @report_url = app_config['report_url']
    @report_user = app_config['report_user']
    @report_user_key = app_config['report_user_key']
  end

  def validate_token
    #todo, should ask if current local token is valid, if not should ask the API for one
    puts "Connector::validate_token >> !"
  end

  def send_report(*args)
    #todo should use an API end_point to send the report of the system.
    puts "Connector::send_report >> ! args: #{args}"
  end

  def authenticate
    #todo should aurhenticate to receive token ???
    puts "Connector::authenticate >> !"
  end
end