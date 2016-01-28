require 'rake'
require 'dotenv'
require 'rspec/core/rake_task'
require './lib/zenruby.rb'

Dotenv.load

desc 'Updates Zendesk fields'
task :update_fields do 
	a = ZennedGit.new
	a.update_ticket_fields
end

RSpec::Core::RakeTask.new(:spec) do |t|
t.pattern = Dir.glob('spec/**/*_spec.rb')
end
task :default => :spec

