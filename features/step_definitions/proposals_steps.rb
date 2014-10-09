Given(/^the proposal has the key "(.*?)"$/) do |arg1|
  @discussion.current_motion.key = arg1
  @discussion.current_motion.save
  @discussion.current_motion.key.should == arg1
end

When(/^I ask the API for the proposal with the key "(.*?)"$/) do |arg1|
  @response = get "/api/v1/proposals/#{arg1}"
end
