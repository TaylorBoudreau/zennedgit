require 'rspec'
require './lib/tickets.rb'
require './spec/fixtures.rb'

RSpec.describe TicketCount do
	
	before( :all ) do
		@ticket_count = TicketCount.new
	end

	describe '#tag_count_exists' do 
		it 'returns true if tag exists in the passed array' do  
			tag = Fixture::Ticket::GOOD_TAG
			count_array = Fixture::Ticket::COUNT_ARRAY
			exists = @ticket_count.tag_count_exists?( tag, count_array)
			
			expect( exists[ 'exists' ] ).to eq( true ) 
		end

		it 'returns false if the tag doesn\'t exist in the passed array' do  
			tag = Fixture::Ticket::BAD_TAG
			count_array = Fixture::Ticket::COUNT_ARRAY
			exists = @ticket_count.tag_count_exists?( tag, count_array)
			
			expect( exists[ 'exists' ] ).to eq( false ) 
		end
	end

	describe '#create_count_hash' do
		it 'returns a hash that includes the tag, cound and ticket id\'s of the tagged tickets' do  
			tag = Fixture::Ticket::GOOD_TAG
			ticket_id = 12
			count_hash = @ticket_count.create_count_hash( tag, ticket_id )

			expect( count_hash[ 'tag' ] ).to eq( Fixture::Ticket::GOOD_TAG )
			expect( count_hash[ 'count' ] ).to eq( 1 )
			expect( count_hash[ 'ticket_ids' ] ).to eq( [ 12 ] )
		end
	end

	describe '#tag_count' do
		it 'returns an array of hashes with the count, zendesk ticket id\'s, and tag name' do
			tag_count_array = @ticket_count.tag_count( Fixture::Ticket::TAGGED_TICKET_ARRAY)

			expect( tag_count_array ).to eq( Fixture::Ticket::COUNT_ARRAY )
		end
	end
end

