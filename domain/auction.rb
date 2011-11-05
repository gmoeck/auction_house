require_relative 'bid'

module AuctionHouse
  class Auction
    def initialize
      @auction_listeners = []
      @highest_bid = AuctionHouse::Bid.new('', 0.0)
    end

    def add_listener(listener)
      @auction_listeners << listener
    end

    def bid(bidder, amount)
      @highest_bid = AuctionHouse::Bid.new(bidder, bid_amount(amount))
      @auction_listeners.each {|listener| listener.highest_bid_updated(@highest_bid)}
    end

    private

    def bid_amount(amount)
      @highest_bid.amount == 0.0 ? amount : @highest_bid.amount + bid_increment
    end

    def bid_increment
      0.50
    end
  end
end
