require 'clockwork'
require 'rake'

load File.join('.', 'Rakefile')

module Clockwork

  handler do |job|
    puts "Running #{job}"
    Rake::Task[job].invoke
  end

  every(5.minutes, 'traffic:check')
  every(1.hour, 'traffic:cleanup')
end