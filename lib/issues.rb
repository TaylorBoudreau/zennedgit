require 'octokit'

class Git
	attr_accessor :client

	def initialize 
		@client = Octokit::Client.new( :access_token => ENV[ "GIT_OAUTH_TOKEN" ] )

		user = @client.user
		user.login
	end
end

class IssueProcessor
	attr_reader :git

	def initialize
		@git = Git.new
	end

	#Gets issues from github and creates an array of name/value hashes out of the issue titles
	#formatted to PUT the updated fields in Zendesk to update the selection
	def process_issue_array
		issues_array = combine_multiple_repos_issues
		cleaned_array = clean_array_for_zendesk( issues_array )
		
		return cleaned_array
	end

	#Takes issues tagged from multiple repos and combines them into a single array to use in ticket field
	def combine_multiple_repos_issues
		all_tagged_issues_array = []
		repos = ENV[ "GIT_ISSUES_REPO" ]
		repos = repos.split(' ')
		
		repos.each do | a |
			repos_issues = get_issues( a, ENV[ "GIT_LABEL" ] )
			all_tagged_issues_array.push( repos_issues ).flatten!
		end
		
		return all_tagged_issues_array
	end

	#Get issues from github repo and return the issues with a specific label
	#This is separated from the cleaned issues as it may be used to provide a useful
	#user facing display of issues
	def get_issues( url, label )
		issues = @git.client.issues( url, :per_page => 100 )
		cleaned_issues = parse_issue_array( issues, label )
		puts cleaned_issues.inspect
		return cleaned_issues
	end

	#Make a pretty issue array to use in Zendesk display
	def parse_issue_array( issues, label )
		tagged_issues_array = []
		issues.each do | a |
			labels = a[ 'labels' ]
			labels.each do | b |
				if b[ 'name' ] == label
					matched_issue = {}
					matched_issue[ 'url' ] = a[ 'html_url' ]
					matched_issue[ 'title' ]= a[ 'title' ]
					matched_issue[ 'number' ] = a[ 'number' ]
					tagged_issues_array.push( matched_issue )
				end
			end
		end

		return tagged_issues_array
	end

	#Takes an array of git issue hashes and puts what's needed into a santized array of hashes 
	#to display a cleaned title and tag in Zendesk
	def clean_array_for_zendesk( issue_array )
		titles = []
		issue_array.each do | a |
			issues = {}
			title = a[ 'title' ]
			url = a[ 'url' ]
			url = url.gsub(/^https:\/\/github.com\/CozyCo\//, '')
			url = url.gsub(/\/issue\w/, '')
			url = url.to_s
			issues[ 'name' ] = title + ' (' + url + ')'
			url.gsub!(/\//, '_')
			title.gsub!(/[^a-zA-Z0-9 ]/, '')
			title.gsub!(/[ ]/, '_')
			title = title + '_' + url
			value = title.downcase
			
			issues[ 'value' ] = value
			titles.push( issues )
		end

		return titles
	end
end

