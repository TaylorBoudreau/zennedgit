require 'rake'
require 'rspec/core/rake_task'

desc 'Updates Zendesk fields'
task :update_fields do 
	require './lib/ticket_field_updator.rb'
end

RSpec::Core::RakeTask.new(:spec) do |t|
t.pattern = Dir.glob('spec/**/*_spec.rb')
end
task :default => :spec

