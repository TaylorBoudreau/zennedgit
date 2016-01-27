require './lib/zenruby.rb'

def get_tagged_ticket_count
	tagged_tickets = get_tagged_tickets
	tagged_ticket_count_array = tag_count( tagged_tickets ) 

	return tagged_ticket_count_array
end

#Return an array of hashes of ticket tags and their counts
#as well as an array of their Zendesk id's

def tag_count( tagged_tickets )
	tag_count_array = []
	ticket_array = tagged_tickets
	ticket_array.each do | ticket |
		 count_exists = tag_count_exists?( ticket[ 'tag' ], tag_count_array )
		if count_exists[ 'exists' ]
			tag_count_array[ count_exists[ 'matched_index' ] ][ 'count' ] += 1
			tag_count_array[ count_exists[ 'matched_index' ] ][ 'ticket_ids' ] |= [ ticket[ 'id' ] ]
		else
			new_tag_count = create_count_hash( ticket[ 'tag' ], ticket[ 'id' ])
			tag_count_array.push( new_tag_count )
		end
	end
	
	return tag_count_array
end

def get_tagged_tickets
	tagged_tickets_array = []
	a = Zendesk.new
	recent_ticket_array = a.get_recent_tickets
	recent_ticket_array.fetch!
	recent_ticket_array.each do | ticket | 
		tagged_ticket = {}
		tickets_fields = ticket.custom_fields
		tickets_fields.each do |a|
			if !a.value.empty?
				tagged_ticket[ 'id' ] = ticket.id			
				tagged_ticket[ 'tag' ] = a.value
				tagged_tickets_array.push( tagged_ticket )
			end
		end
	end
	
	return tagged_tickets_array
end

def create_count_hash( tag, ticket_id)
	count_hash = {}
	count_hash[ 'tag' ] = tag
	count_hash[ 'count' ] = 1
	count_hash[ 'ticket_ids' ] = [ ticket_id ]
	return count_hash
end

def tag_count_exists?( tag, count_array )
	exists = false
	index = nil
	return_hash = {}
	count_array.each do | count_hash | 
		if count_hash[ 'tag' ] == tag 
			exists = true
			index = count_array.index( count_hash )
		end
	end
	return_hash[ 'exists' ] = exists
	return_hash[ 'matched_index' ] = index
	
	return return_hash
end

a = get_tagged_ticket_count
puts a.inspect

