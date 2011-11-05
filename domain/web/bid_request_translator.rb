module AuctionHouse
  class WebAuctionRequestTranslator
    def initialize(auction_event_listener)
      @auction_event_listener = auction_event_listener
    end

    def process_request(parameters)
      @auction_event_listener.bid(parameters[:bidder], parameters[:maximum_bid]) if parameters[:type] == 'update'
    end
  end
end
