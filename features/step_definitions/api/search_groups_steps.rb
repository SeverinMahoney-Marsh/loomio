Given(/^I am an API user$/) do
  # Perhaps the API will be secured somehow to prevent abuse
end

Given(/^there is a group called "(.*?)"$/) do |arg1|
  @group = FactoryGirl.create :group, name: arg1
end

Given(/^the group has the subdomain "(.*?)"$/) do |arg1|
  @group.subdomain = arg1
  @group.save
end

Given(/^the group is public$/) do
  @group.is_visible_to_public = true
  @group.save
end

When(/^I ask the API for the group with the subdomain "(.*?)"$/) do |arg1|
  # For some reason when api_search_group_path is used it does not add the /v1 to the path
  @response = get "/api/v1/search_groups/#{arg1}"
end

Then(/^I should recieve information about the group$/) do
  @response.status.should == 200
  info = JSON.parse @response.body
  info.should_not == nil
end

Given(/^the group is private$/) do
  @group.is_visible_to_public = false
  @group.save
end

Then(/^I should recieve the status (\d+)$/) do |arg1|
  @response.status.should == arg1.to_i
end
