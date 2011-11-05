Dir[Rails.root + 'domain/**/*.rb'].each { |file| require file }

#Instantiation of objects happens here, functions like a main function for the domain
module AuctionHouse
  module Domain
    def self.setup
      @web_auction_view_model = AuctionHouse::WebAuctionViewModel.new
      @auction = AuctionHouse::Auction.new(@web_auction_view_model)
      @web_auction_request_translator = AuctionHouse::WebAuctionRequestTranslator.new(@auction)
    end

    def self.reset
      self.setup
    end

    def self.auction_view_model
      @web_auction_view_model
    end

    def self.auction_request_translator
      @web_auction_request_translator
    end
  end
end

AuctionHouse::Domain.setup
