When(/^I create a subscription with the subdomain "(.*?)", a tag "(.*?)", and a path "(.*?)"$/) do |arg1, arg2, arg3|
  @subscription = { :subdomain => arg1, :tag => arg2, :path => arg3 }
end

When(/^I ask the API to create the subscription$/) do
  @response = post "/api/v1/api_group_subscriptions", @subscription
end

Then(/^The subscription should be added to the group$/) do
  @response.status.should == 200
  subscription = JSON.parse @response.body
  subscription.should_not == nil
  subscription["tag"].should == @subscription[:tag]
  subscription["path"].should == @subscription[:path]
end
