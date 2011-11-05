require_relative '../auction_state'

module AuctionHouse
  class WebAuctionViewModel
    module ResponseTypes
      NO_BIDS = 0
      LAST_BID_SUCCESSFUL = 1
      LAST_BID_FAILED = 2
    end

    def initialize(params={})
      @auction_state = AuctionHouse::AuctionState.new('', 0.00)
      @response_type = ResponseTypes::NO_BIDS
    end

    def bid_successful(auction_state)
      @response_type = ResponseTypes::LAST_BID_SUCCESSFUL
      @auction_state = auction_state
    end

    def bid_failed(auction_state)
      @response_type = ResponseTypes::LAST_BID_FAILED
      @auction_state = auction_state
    end

    def status_message
      return '' if @response_type == ResponseTypes::NO_BIDS
      return 'Bid Accepted. You are now the highest bidder.' if @response_type == ResponseTypes::LAST_BID_SUCCESSFUL
      'Bid Failed.'
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
