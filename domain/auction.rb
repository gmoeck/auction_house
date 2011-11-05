require_relative 'auction_state'

module AuctionHouse
  class Auction
    def initialize
      @auction_listeners = []
      @highest_current_bid = 0.0
      @current_high_bidder = ''
    end

    def add_listener(listener)
      @auction_listeners << listener
    end

    def bid(bidder, amount)
      @current_high_bidder = bidder
      @highest_current_bid = bid_amount(amount)
      @auction_listeners.each {|listener| listener.auction_state_updated(AuctionHouse::AuctionState.new(@current_high_bidder, @highest_current_bid))}
    end

    private

    def bid_amount(amount)
      @highest_current_bid == 0.0 ? amount : @highest_current_bid + bid_increment
    end

    def bid_increment
      0.50
    end
  end
end
