Feature: Search for active proposals via API
	In order to find active proposals based on user input
	As an API user
	I need to search for active proposals

	Background:
		Given I am an API user

	Scenario: There is an active proposal to find
		Given there is a group called "Mischief"
		And the group has the subdomain "mischief"
		And the group is public
		And the group has a discussion
		And the discussion is public
		And the discussion has an open proposal
		When I ask the API for the active proposals within subdomain "mischief"
		Then I should recieve the proposal
	
	Scenario: There isn't an active proposal to find
		Given there is a group called "Mischief"
		And the group has the subdomain "mischief"
		And the group is public
		When I ask the API for the active proposals within subdomain "mischief"
		Then I should not recieve the proposal

	Scenario: There is an active proposal but it is in a private group
		Given there is a group called "Mischief"
		And the group has the subdomain "mischief"
		And the group is public
		And the group has a discussion
		And the discussion is not public
		And the discussion has an open proposal
		When I ask the API for the active proposals within subdomain "mischief"
		Then I should not recieve the proposal
	
	Scenario: The group exists and is private
		Given there is a group called "Mischief"
		And the group has the subdomain "mischief"
		And the group is private
		When I ask the API for the active proposals within subdomain "mischief"
		Then I should recieve the status 403

	Scenario: The group does not exist
		When I ask the API for the active proposals within subdomain "mischief"
		Then I should recieve the status 404
