require 'rspec'
require './lib/zenruby.rb'


RSpec.describe Zendesk do 

	before( :all ) do 
		@dirty_issue_array = [{"url"=>"https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/issues/4", "title"=>"Applicants do a thing from previous employers so it's automatically given a number somewhere", "number"=>4},
							 {"url"=>"https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/issues/1", "title"=>"This look a bit janky.", "number"=>1}]

		@cleaned_issue_array = [{"name"=>"Applicants do a thing from previous employers so it's automatically given a number somewhere (#4)", "value"=>"applicants_do_a_thing_from_previous_employers_so_its_automatically_given_a_number_somewhere"}, 
						{"name"=>"This look a bit janky. (#1)", "value"=>"this_look_a_bit_janky"}]
	end

	describe 'make an authenticated request to Zendesk' do

		it 'that receives a successful response' do
			a = Zendesk.new
			tickets = a.client.tickets.first
			
			expect( tickets['id'] ).to eq( 1 )
		end
	end

	describe 'issue processing' do
		
		it 'that creates an array of clean issues' do
			clean_issues = get_clean_issues_array( @dirty_issue_array )
			
			expect( clean_issues ).to eq( @cleaned_issue_array )
		end
	end
end

