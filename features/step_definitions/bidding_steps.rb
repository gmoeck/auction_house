When /^"([^"]*)" bids "([^"]*)"$/ do |bidder, amount|
  visit root_path
  fill_in 'Bidder', :with => bidder
  fill_in 'Maximum Bid', :with => amount
  click_button "Submit"
end

Then /^"([^"]*)" should be the highest bidder$/ do |bidder|
  find('#highest_bidder').text.should == bidder
end

Then /^"([^"]*)" should be the highest bid$/ do |bid|
  find('#highest_bid').text.should include(bid)
end
