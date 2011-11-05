require_relative 'auction_state'

module AuctionHouse
  class Auction
    def initialize(auction_listener)
      @auction_listener = auction_listener
      @highest_current_bid = 0.0
      @current_high_bidder = ''
    end

    def bid(bidder, amount)
      if amount > @highest_current_bid
        @highest_current_bid = amount
        @current_high_bidder = bidder
        @auction_listener.bid_successful(AuctionHouse::AuctionState.new(bidder,amount))
      else
        @auction_listener.bid_failed(AuctionHouse::AuctionState.new(@current_high_bidder, @highest_current_bid))
      end
    end
  end
end
