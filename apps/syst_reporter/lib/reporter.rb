require "yaml"
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
      @connector.send_report(get_data)
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
      uw_diskused: @usw.uw_diskused,
      uw_diskused_perc: @usw.uw_diskused_perc,
      uw_memused: @usw.uw_memused,
      uw_cpuused: @usw.uw_cpuused,
      uw_cputop: @usw.uw_cputop,
      uw_memtop: @usw.uw_memtop
    }
  end
end