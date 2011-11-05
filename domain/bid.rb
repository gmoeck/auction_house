module AuctionHouse
  class Bid
    attr_reader :bidder, :amount
    def initialize(bidder, amount)
      @bidder = bidder
      @amount = amount
    end

    def ==(bid)
      @bidder == bid.bidder && @amount == bid.amount
    end
  end
end
