require 'rest-client'
require 'json'
require './config.rb'

#Get issues from github repo and return the issues with a specific label
def get_issues( url, label )
	res = RestClient.get( url )
	response = JSON.parse(res.body)
	tagged_issues_array = []

	case res.code
	when 200
		response.each do |a|
			labels = a['labels']
			labels.each do |b|
				if b['name'] == label
					matched_issue = {}
					matched_issue['url'] = a['html_url']
					matched_issue['title']= a['title']
					matched_issue['number'] = a['number']
					tagged_issues_array.push( matched_issue )
				end
			end
		end
	else
		raise 'Error!'
	end
	return tagged_issues_array
end


#Gets issues from github and creates an array of name/value hashes out of the issue titles
#formatted to PUT the updated fields in Zendesk to update the selection
def process_issue_array
	array = get_issues( ZenRuby::Config::GIT_ISSUES_URL, ZenRuby::Config::GIT_LABEL )
	titles = []
	array.each do |a|
		title = a['title']
		issues = {}
		issues['name'] = title + ' (#' + a['number'].to_s + ')'
		title.gsub!(/[^a-zA-Z0-9 ]/, '')
		title.gsub!(/[ ]/, '_')
		value = title.downcase
		issues['value'] = value
		titles.push( issues )
	end
	return titles
end

