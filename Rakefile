require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
# import "./lib/tasks/enum_tables.rake"
# require 'enum_weasel/tasks/'

load "./lib/tasks/enum_tables.rake"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

# task :console do
#   exec 'pry -r enum_weasel -I ./lib'
# end

# task :generate_enum_tables do
#   puts "weasel"
# end


# task :consoleTest do
#   exec 'pry -r enum_weasel -I ./lib'
# end

# task :weasel do
#   Test.new.ping
# end