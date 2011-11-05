require_relative '../auction_state'

module AuctionHouse
  class WebAuctionViewModel
    def initialize
      @auction_state = AuctionHouse::AuctionState.new('', 0.00)
      @status_message = ''
    end

    def bid_successful
      @status_message = 'Bid Accepted. You are now the highest bidder.'
    end

    def bid_failed
      @status_message = 'Bid Failed.'
    end

    def auction_state_updated(auction_state)
      @auction_state = auction_state
    end

    def status_message
      @status_message
    end

    def has_status_message?
      not(self.status_message.empty?)
    end

    def highest_bidder
      @auction_state.highest_bidder
    end

    def max_bid
      @auction_state.max_bid
    end
  end
end
