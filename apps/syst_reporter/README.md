#SYST_REPORTER

This project is meant to be a reporter from a server to a system manager application, through REST services.

Dependencies (if not using the Gemfile):

  gem "usagewatch_ext"

  gem "clockwork"

  gem 'daemons'

  gem 'unirest'



#Setup steps:

within the root folder: "bundle install"

#Running steps:

within the root folder: bundle exec clockwork lib/runner.rb
