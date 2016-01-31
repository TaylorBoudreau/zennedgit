require 'rake'
require 'dotenv'
require 'rspec/core/rake_task'
require './lib/zenruby.rb'
require './lib/tickets.rb'

Dotenv.load

desc 'Updates Zendesk fields'
task :update_fields do 
	a = ZennedGit.new
	a.update_ticket_fields
end

desc 'Retrieve tagged tickets'
task :tagged_tickets do 
	a = TicketCount.new
	a.get_tagged_ticket_count
end

RSpec::Core::RakeTask.new(:spec) do |t|
t.pattern = Dir.glob('spec/**/*_spec.rb')
end
task :default => :spec

