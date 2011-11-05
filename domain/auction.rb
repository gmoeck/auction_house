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
        @auction_listener.bid_successful
        change_state(bidder, bid_amount(amount))
      else
        @auction_listener.bid_failed
      end
    end

    private

    def change_state(bidder, amount)
      @current_high_bidder = bidder
      @highest_current_bid = amount
      @auction_listener.auction_state_updated(AuctionHouse::AuctionState.new(@current_high_bidder, @highest_current_bid))
    end

    def bid_amount(amount)
      @highest_current_bid == 0.0 ? amount : @highest_current_bid + bid_increment
    end

    def bid_increment
      0.50
    end
  end
end
