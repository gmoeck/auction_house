module AuctionHouse
  class BidCalculator
    def initialize(bid_processor)
      @bid_processor = bid_processor
    end

    def bid(bidder, max_offer)
      @bid_processor.bid(bidder, bid_amount(max_offer))
    end

    def bid_amount(max_offer)
      @highest_bid.nil? ? max_offer : @highest_bid + increment_for(@highest_bid)
    end

    def highest_bid_updated(bid)
      @highest_bid = bid.amount
    end

    private

    def increment_for(amount)
      if amount < 1.00
        0.05
      elsif amount < 5.00
        0.25
      elsif amount < 25.00
        0.50
      elsif amount > 0.0
        1.00
      end
    end
  end
end