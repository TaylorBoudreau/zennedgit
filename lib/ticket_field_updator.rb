require './lib/zenruby.rb'

begin
	a = Zendesk.new
	a.update_ticket_fields
rescue Exception => e
	raise e
end