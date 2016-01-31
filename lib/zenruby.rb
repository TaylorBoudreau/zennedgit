require 'zendesk_api'
require 'logger'
require './lib/issues.rb'

#Create an authenticated Zendesk client to easily make authenticated requests
class ZennedGit
	attr_reader :client
	
	def initialize
		@client = ZendeskAPI::Client.new do |config|
			config.url = ENV[ "ZENDESK_API_URL" ]
			config.username = ENV[ "ZENDESK_USERNAME" ]
			config.token = ENV[ "ZENDESK_TOKEN" ]
			config.retry = true
			config.logger = Logger.new(STDOUT)
		end
	end

	def self::client
		@client
	end

	#This gets the current fields in the zendesk ticket field
	def current_fields_array
		fields = self.client.ticket_fields.find( :id => ENV[ "TICKET_FIELD_ID" ] )
		fields = fields[ 'custom_field_options' ]
		return fields
	end

	#PUT to zendesk to update ticket fields
	def update_ticket_fields
		fields = self.client.ticket_fields.find( :id => ENV[ "TICKET_FIELD_ID" ] )
		issues = IssueProcessor.new
		fields['custom_field_options'] = issues.process_issue_array
		fields.save!
		return fields['custom_field_options']
	end

	def get_recent_tickets
		tickets = self.client.tickets
		tickets.fetch!
		return tickets
	end
end

