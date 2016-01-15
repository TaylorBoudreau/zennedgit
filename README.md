# Zennedgit

This will get a list of issues from a specified repo, santize the issue list based on a label that you want passed to Zendesk,
then generate the options in a custom field in Zendesk for ticket tagging of zendesk issues.

After updating the config file with your credentials +bundle install+ and +bundle exec rake update_fields+ will run the field updator. 

I've deployed this to heroku and am using their free scheduler to run this daily.

TODO:

-Pull Zendesk tickets for tag count and analysis outside of Zendesk

-More refactoring for better testing
