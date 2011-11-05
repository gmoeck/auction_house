require_relative '../bid'

module AuctionHouse
  class WebAuctionViewModel
    def initialize
      @highest_bid = AuctionHouse::Bid.new('', 0.00)
      @status_message = ''
    end

    def bid_successful
      @status_message = 'Bid Accepted. You are now the highest bidder.'
    end

    def bid_failed
      @status_message = 'Bid Failed.'
    end

    def highest_bid_updated(highest_bid)
      @highest_bid = highest_bid
    end

    def status_message
      @status_message
    end

    def has_status_message?
      not(self.status_message.empty?)
    end

    def highest_bidder
      @highest_bid.bidder
    end

    def max_bid
      @highest_bid.amount
    end
  end
end
