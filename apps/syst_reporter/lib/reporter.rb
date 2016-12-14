require 'yaml'
require 'usagewatch_ext'
require_relative 'connector.rb'

class Reporter
  def initialize(*args)
    puts "Reporter::initialize >> !"
    app_config = YAML::load_file(File.join(__dir__, '../config/app.yml'))
    @os = app_config['os']
    raise "Unrecognized OS, please use 'LINUX' or 'MACOS'" unless ['LINUX', 'MACOS'].index(@os)
    @usw = Usagewatch
     @connector = Connector.new(app_config)
  end

  def report!
    begin
      puts "Reporter::report! >> !"
      puts "will connect with @connector: #{@connector}"
      data = get_data
      puts "Reporter::report! >> data: #{data}"
      @connector.update_server(data)
    rescue => error
      puts "Reporter::report! >> ERROR: #{error}"
    end
  end

  def get_data
    puts "Reporter::get_data >> !"
    if ['LINUX', 'MACOS'].index(@os)
      get_mapped_report
    else
      raise "No OS initialized, please check configuration of Reporter"
    end
  end

  def get_mapped_report
    {
      disk_used: @usw.uw_diskused,
      disk_used_percent: @usw.uw_diskused_perc,
      memory_used: @usw.uw_memused,
      cpu_used: @usw.uw_cpuused,
      cpu_processes: @usw.uw_cputop.to_s,
      memory_processes: @usw.uw_memtop.to_s
    }
  end
end