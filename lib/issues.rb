require 'rest-client'
require 'json'
require './config.rb'

#Gets issues from github and creates an array of name/value hashes out of the issue titles
#formatted to PUT the updated fields in Zendesk to update the selection
def process_issue_array
	issues_array = get_issues( ZenRuby::Config::GIT_ISSUES_URL, ZenRuby::Config::GIT_LABEL )
	cleaned_array = get_clean_issues_array( issues_array )
	return cleaned_array
end

#Get issues from github repo and return the issues with a specific label
#This is separated from the cleaned issues as it may be used to provide a useful
#user facing display of issues
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

#Takes an array of git issue hashes and puts what's needed into a santized array of hashes 
#to display a cleaned title and tag in Zendesk
def get_clean_issues_array( issue_array )
	titles = []
	issue_array.each do | a |
		title = a[ 'title' ]
		issues = {}
		issues[ 'name' ] = title + ' (#' + a[ 'number' ].to_s + ')'
		title.gsub!(/[^a-zA-Z0-9 ]/, '')
		title.gsub!(/[ ]/, '_')
		value = title.downcase
		issues[ 'value' ] = value
		titles.push( issues )
	end
	return titles
end

