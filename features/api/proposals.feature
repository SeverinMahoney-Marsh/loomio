Feature: Search proposals via API
	In order to find a particular proposal based on user input
	As an API user
	I need to search proposals

	Background:
		Given I am an API user

	Scenario: The proposal exists and is public
		Given there is a group called "Voodoo"
		And the group is public
		And the group has a discussion
		And the discussion is public
		And the discussion has an open proposal
		And the proposal has the key "unlikely"
		When I ask the API for the proposal with the key "unlikely"
		Then I should recieve the proposal
	
	Scenario: The proposal exists and is private
		Given there is a group called "Voodoo"
		And the group is public
		And the group has a discussion
		And the discussion is not public
		And the discussion has an open proposal
		And the proposal has the key "unlikely"
		When I ask the API for the proposal with the key "unlikely"
		Then I should recieve the status 403
	
	Scenario: The proposal does not exist
		When I ask the API for the proposal with the key "unlikely"
		Then I should recieve the status 404
