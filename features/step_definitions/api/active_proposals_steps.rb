Given(/^the discussion is public$/) do
  @discussion.private = false
  @discussion.save
end

When(/^I ask the API for the active proposals within subdomain "(.*?)"$/) do |arg1|
  @response = get "/api/v1/active_proposals/#{arg1}"
end

Then(/^I should recieve the proposal$/) do
  @response.status.should == 200
  data = JSON.parse @response.body
  data.should_not == nil
  data.empty?.should == false
end

Given(/^the discussion is not public$/) do
  @discussion.private = true
  @discussion.save
end

Then(/^I should not recieve the proposal$/) do
  @response.status.should == 200
  data = JSON.parse @response.body
  data.should_not == nil
  data.empty?.should == true
end
