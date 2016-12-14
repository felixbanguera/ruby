require 'yaml'
require 'rest-client'
require 'json'

class Connector
  def initialize(app_config)
    #app_config = YAML::load_file(File.join(__dir__, '../config/app.yml'))
    @server_id = app_config['server_id']
    @server_os = app_config['os']
    @server_ip = app_config['server_ip']
    @server_uid = app_config['server_uid']
    @report_url = app_config['report_url']
    @client_id = app_config['client_id']
    @client_secret = app_config['client_secret']
    @user_email = app_config['user_email']
    @user_pwd = app_config['user_pwd']
    @server_name = app_config['server_name']
    @user_token = app_config['user_secret']
  end

  def get_application_token
    response = RestClient.post("#{@report_url}/oauth/token", {
      grant_type: 'client_credentials',
      client_id: @client_id,
      client_secret: @client_secret
    })
    app_token = JSON.parse(response)["access_token"]
    puts "app_token: ::::: #{app_token}"
    #todo : write app_token to app.yml
    # [#<Doorkeeper::Application id: 1, name: "syst_reporter", uid: "d379011c5fc6ce6d8a78d75e7e58d3dba72a837a256712a4d7...", secret: "9d203d753836cae1fa527a12ca88d7be5e83a439305589a37c...", redirect_uri: "urn:ietf:wg:oauth:2.0:oob", scopes: "", created_at: "2016-12-14 15:29:34", updated_at: "2016-12-14 15:29:34">
  end

  def get_user_token
    begin
      response = RestClient.post("#{@report_url}/oauth/token", {
        grant_type: 'password',
        client_id: @client_id,
        email: @user_email,
        password: @user_pwd
      })
      @user_token = JSON.parse(response)["access_token"]
      puts "user_token: ::::: #{@user_token}"
      #todo : write user_token to app.yml
      app_config = YAML::load_file(File.join(__dir__, '../config/app.yml'))
      app_config['user_secret'] = @user_token
      File.open(File.join(__dir__, '../config/app.yml'), 'w') {|f| f.write app_config.to_yaml } #Store
    rescue => error
      puts "Connector::register_server >> ERROR: #{error}"
    end
  end

  def register_server
    begin
      puts "Connector::register_server >> @server_name: #{@server_name}"
      response = RestClient.post("#{@report_url}/api/v1/servers/new",
      {name: @server_name,
       ip: @server_ip,
       so: @server_os},
      {'Authorization' => "Bearer #{@user_token}"})
      response = JSON.parse(response)
      puts "Server created: ::::: #{response['servers']['uid']}"
      app_config = YAML::load_file(File.join(__dir__, '../config/app.yml'))
      app_config['server_uid'] = response['servers']['uid']
      File.open(File.join(__dir__, '../config/app.yml'), 'w') {|f| f.write app_config.to_yaml } #Store
    rescue => error
      puts "Connector::register_server >> ERROR: #{error}"
    end
  end

  def get_servers
    puts "Connector::get_servers >> @user_token: #{@user_token}"
    response = RestClient.get("#{@report_url}/api/v1/servers",
    {'Authorization' => "Bearer #{@user_token}"})
    response = JSON.parse(response)
    puts "Servers list: ::::: #{response}"
  end

  def update_server(data)
    puts "Connector::update_server >> "
    response = RestClient.put("#{@report_url}/api/v1/servers",
    {name: @server_name,
     uid: @server_uid,
     ip: @server_ip,
     so: @server_os}.merge(data),{'Authorization' => "Bearer #{@user_token}"})
    response = JSON.parse(response)
    puts "Server created: ::::: #{response}"
  end
end