Feature: Search for groups via API
	In order to find a particular loomio group based on user input
	As an API user
	I need to search groups

	Background:
		Given I am an API user

	Scenario: The group exists and is public
		Given there is a group called "Lemonade"
		And the group has the subdomain "lemonade"
		And the group is public
		When I ask the API for the group with the subdomain "lemonade"
		Then I should recieve information about the group
	
	Scenario: The group exists and is private
		Given there is a group called "Lemonade"
		And the group has the subdomain "lemonade"
		And the group is private
		When I ask the API for the group with the subdomain "lemonade"
		Then I should recieve the status 403

	Scenario: The group does not exits
		When I ask the API for the group with the subdomain "lemonade"
		Then I should recieve the status 404
