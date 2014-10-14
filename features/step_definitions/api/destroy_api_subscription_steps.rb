Given(/^the group has a subscription with the tag "(.*?)", and a path "(.*?)"$/) do |arg1, arg2|
  @group.api_group_subscriptions.create tag: arg1, path: arg2
end

When(/^I ask the API to destroy the subscription with the subdomain "(.*?)", a tag "(.*?)", and a path "(.*?)"$/) do |arg1, arg2, arg3|
  @response = delete "/api/v1/api_group_subscriptions/#{arg1}", {:tag => arg2, :path => arg3}
end

Then(/^The subscription should nolonger exist$/) do
  @group.reload
  @group.api_group_subscriptions.empty?.should == true
end

Then(/^The subscription should exist$/) do
  @group.reload
  @group.api_group_subscriptions.empty?.should_not == true
end
