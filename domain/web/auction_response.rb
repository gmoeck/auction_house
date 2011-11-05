module AuctionHouse
  class WebAuctionResponse
    attr_accessor :highest_bidder, :max_bid

    def initialize(params={})
      @highest_bidder = ''
      @max_bid = 0.0
    end

    def bid(bidder, amount)
      @highest_bidder = bidder
      @max_bid = amount
    end
  end
end
