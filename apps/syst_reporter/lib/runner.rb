require 'clockwork'
require_relative 'reporter.rb'
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(30.seconds, 'test.frequent.job') do
    puts "Job test to see the Runner is running"
    reporter = Reporter.new
    reporter.report!
  end
end