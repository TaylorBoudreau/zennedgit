require 'rspec'
require './lib/zenruby.rb'


RSpec.describe ZennedGit do 

	before( :all ) do 
		@dirty_issue_array = [{"url"=>"https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/issues/4", "title"=>"Applicants do a thing from previous employers so it's automatically given a number somewhere", "number"=>4},
							 {"url"=>"https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/issues/1", "title"=>"This look a bit janky.", "number"=>1}]

		@cleaned_issue_array = [{"name"=>"Applicants do a thing from previous employers so it's automatically given a number somewhere (https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/4)", "value"=>"applicants_do_a_thing_from_previous_employers_so_its_automatically_given_a_number_somewhere_https:__github.com_taylorboudreau_taylorboudreau.github.io_4"}, {"name"=>"This look a bit janky. (https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/1)", "value"=>"this_look_a_bit_janky_https:__github.com_taylorboudreau_taylorboudreau.github.io_1"}]
	end

	describe 'make an authenticated request to Zendesk' do

		it 'that receives a successful response' do
			a = ZennedGit.new
			tickets = a.client.tickets.first
			
			expect( tickets['id'] ).to eq( 1 )
		end
	end
end

RSpec.describe IssueProcessor do 
	
	before( :all ) do
		@issueprocessor = IssueProcessor.new

		@dirty_issue_array = [{"url"=>"https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/issues/4", "title"=>"Applicants do a thing from previous employers so it's automatically given a number somewhere", "number"=>4},
							 {"url"=>"https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/issues/1", "title"=>"This look a bit janky.", "number"=>1}]

		@cleaned_issue_array = [{"name"=>"Applicants do a thing from previous employers so it's automatically given a number somewhere (https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/4)", "value"=>"applicants_do_a_thing_from_previous_employers_so_its_automatically_given_a_number_somewhere_https:__github.com_taylorboudreau_taylorboudreau.github.io_4"}, {"name"=>"This look a bit janky. (https://github.com/TaylorBoudreau/TaylorBoudreau.github.io/1)", "value"=>"this_look_a_bit_janky_https:__github.com_taylorboudreau_taylorboudreau.github.io_1"}]
	end

	describe 'issue processing' do

		it 'parses issue array to remove irrelevant issues based on label' do
			issues = @issueprocessor.get_issues( 'TaylorBoudreau/TaylorBoudreau.github.io', 'zendesk' )
			puts issues.inspect

			expect( issues.empty? ).to eq( false )
		end

		it 'does not include issues where the label does not match' do
			issues = @issueprocessor.get_issues( 'TaylorBoudreau/TaylorBoudreau.github.io', 'this_is_not_a_label_that_will_ever_exist' ) 

			puts issues.inspect
			expect( issues ).to eq( [] )
		end

		it 'that creates an array of clean issues' do
			clean_issues = @issueprocessor.clean_array_for_zendesk( @dirty_issue_array )
			
			expect( clean_issues ).to eq( @cleaned_issue_array )
		end
	end
end

