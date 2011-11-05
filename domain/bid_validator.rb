module AuctionHouse
  class BidValidator
    def initialize(bid_processor, bid_listener)
      @bid_processor = bid_processor
      @bid_listener  = bid_listener
      @highest_bid = 0.0
    end

    def highest_bid_updated(max_bid)
      @highest_bid = max_bid.amount
    end

    def bid(bidder, amount)
      if @highest_bid < amount
        @bid_listener.bid_successful
        @bid_processor.bid(bidder, amount)
      else
        @bid_listener.bid_failed
      end
    end
  end
end