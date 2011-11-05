require_relative '../auction_state'

module AuctionHouse
  class WebAuctionResponse
    def initialize(params={})
      @auction_state = AuctionHouse::AuctionState.new('', 0.00)
    end

    def bid_successful(auction_state)
      @auction_state = auction_state
    end

    def bid_failed(auction_state)
      @auction_state = auction_state
    end

    def highest_bidder
      @auction_state.highest_bidder
    end

    def max_bid
      @auction_state.max_bid
    end
  end
end
