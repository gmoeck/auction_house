Dir[Rails.root + 'domain/**/*.rb'].each { |file| require file }

#Instantiation of objects happens here, functions like a main function for the domain
module AuctionHouse
  module Domain
    @web_auction_response = AuctionHouse::WebAuctionResponse.new
    @web_auction_request_translator = AuctionHouse::WebAuctionRequestTranslator.new(@web_auction_response)

    def self.auction_response
      @web_auction_response
    end

    def self.auction_request_translator
      @web_auction_request_translator
    end
  end
end
