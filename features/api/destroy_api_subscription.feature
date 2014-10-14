Feature: Destroy an api group subscription
	In order ignore groups I am no longer interested in
	As an API user
	I need to unsubscribe to the group

	Background:
		Given I am an API user

	Scenario: The group exists and is public
		Given there is a group called "Rose"
		And the group has the subdomain "rose"
		And the group is public
		And the group has a subscription with the tag "ruby", and a path "realUrl"
		When I ask the API to destroy the subscription with the subdomain "rose", a tag "ruby", and a path "realUrl"
		Then The subscription should nolonger exist
	
	Scenario: The group exists and is public but the subscription doesn't match
		Given there is a group called "Rose"
		And the group has the subdomain "rose"
		And the group is public
		And the group has a subscription with the tag "ruby", and a path "realUrl"
		When I ask the API to destroy the subscription with the subdomain "rose", a tag "emerald", and a path "realUrl"
		Then The subscription should exist
	
	Scenario: The group exists and is private
		Given there is a group called "Rose"
		And the group has the subdomain "rose"
		And the group is private
		When I ask the API to destroy the subscription with the subdomain "rose", a tag "ruby", and a path "realUrl"
		Then I should recieve the status 403

	Scenario: The group does not exist
		When I ask the API to destroy the subscription with the subdomain "rose", a tag "ruby", and a path "realUrl"
		Then I should recieve the status 404
