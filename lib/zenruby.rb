require 'zendesk_api'
require 'logger'
require './lib/issues.rb'
require './config.rb'

#Create an authenticated Zendesk client to easily make authenticated requests
class Zendesk
	attr_reader :client
	
	def initialize
		@client = ZendeskAPI::Client.new do |config|
			config.url = ZenRuby::Config::ZENDESK_API_URL
			config.username = ZenRuby::Config::ZENDESK_USERNAME
			config.token = ZenRuby::Config::ZENDESK_TOKEN
			config.retry = true
			config.logger = Logger.new(STDOUT)
		end
	end

	def self::client
		@client
	end

	#This gets the current fields in the zendesk ticket field
	def current_fields_array
		fields = self.client.ticket_fields.find( :id => ZenRuby::Config::TICKET_FIELD_ID )
		fields = fields[ 'custom_field_options' ]
		return fields
	end

	#PUT to zendesk to update ticket fields
	def update_ticket_fields
		fields = self.client.ticket_fields.find( :id => ZenRuby::Config::TICKET_FIELD_ID )
		fields['custom_field_options'] = process_issue_array
		fields.save!
		return fields['custom_field_options']
	end

	def get_recent_tickets
		tickets = self.client.tickets
		tickets.fetch!
		return tickets
	end
end

