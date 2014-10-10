Feature: Create an api group subscription
	In order to keep up to date with the happenings of a group
	As an API user
	I need to subscribe to the group

	Background:
		Given I am an API user

	Scenario: The group exists and is public
		Given there is a group called "Rose"
		And the group has the subdomain "rose"
		And the group is public
		When I create a subscription with the subdomain "rose", a tag "ruby", and a path "realUrl"
		And I ask the API to create the subscription
		Then The subscription should be added to the group
	
	Scenario: The group exists and is private
		Given there is a group called "Rose"
		And the group has the subdomain "rose"
		And the group is private
		When I create a subscription with the subdomain "rose", a tag "ruby", and a path "realUrl"
		And I ask the API to create the subscription
		Then I should recieve the status 403

	Scenario: The group does not exist
		When I create a subscription with the subdomain "rose", a tag "ruby", and a path "realUrl"
		And I ask the API to create the subscription
		Then I should recieve the status 404
