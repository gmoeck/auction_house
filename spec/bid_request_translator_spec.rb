require_relative '../domain/web/auction_request_translator'

describe AuctionHouse::WebAuctionRequestTranslator do
  before(:each) do
    @auction_event_listener = double('auction event listener')
    @translator = AuctionHouse::WebAuctionRequestTranslator.new(@auction_event_listener)
  end

  it "notifies the auction event listener of new bids" do
    parameters = {:type => 'update', :bidder => "Greg", :maximum_bid => '15.00'}

    @auction_event_listener.should_receive(:bid).with("Greg", 15.00)

    @translator.process_request(parameters)
  end

  it "does nothing on a show request" do
    parameters = {:type => 'show'}

    @auction_event_listener.should_not_receive(:bid)

    @translator.process_request(parameters)
  end
end
