require_relative 'bid'

module AuctionHouse
  class Auction
    def initialize
      @auction_listeners = []
    end

    def add_listener(listener)
      @auction_listeners << listener
    end

    def bid(bidder, amount)
      @highest_bid = AuctionHouse::Bid.new(bidder, amount)
      @auction_listeners.each {|listener| listener.highest_bid_updated(@highest_bid)}
    end
  end
end