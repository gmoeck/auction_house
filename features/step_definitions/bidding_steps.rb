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

Then /^"([^"]*)" should be notified that they are the highest bidder$/ do |bidder|
  find('#auction_status').text.should include("Bid Accepted. You are now the highest bidder.")
end

Then /^"([^"]*)" should be notified that their bid failed$/ do |bidder|
  find('#auction_status').text.should include("Bid Failed.")
end

Then /^"([^"]*)" should be notified that their bid was successful, but that they were outbid$/ do |arg1|
  find('#auction_status').text.should include("Bid Accepted, but you were outbid.")
end
