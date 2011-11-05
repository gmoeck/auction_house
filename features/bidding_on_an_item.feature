Feature: Bidding on an auction item

  Scenario: Bidding on an item that nobody has bid on yet
    # Given an auction for an item
     When "Joe" bids "15.00"
     Then "Joe" should be notified that they are the highest bidder
      And "Joe" should be the highest bidder
      And "15.00" should be the highest bid

  Scenario: Two people bid on an item the second person does not outbid the first person
    # Given an auction for an item
    When "Joe" bids "15.00"
    Then "Joe" should be notified that they are the highest bidder
     And "Jane" bids "14.00"
     And "Jane" should be notified that their bid failed
    Then "Joe" should be the highest bidder
     And "15.00" should be the highest bid
