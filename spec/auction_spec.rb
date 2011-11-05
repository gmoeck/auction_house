require_relative '../domain/auction'

describe AuctionHouse::Auction do
  it "reports that the highest bid was updated when a bid arrives" do
    @auction_listener = double('auction listener')
    @auction_listener2 = double('a second auction listener')
    @auction = AuctionHouse::Auction.new
    @auction.add_listener(@auction_listener)
    @auction.add_listener(@auction_listener2)

    @auction_listener.should_receive(:highest_bid_updated).with(AuctionHouse::Bid.new("Joe", 15.00))
    @auction_listener2.should_receive(:highest_bid_updated).with(AuctionHouse::Bid.new("Joe", 15.00))

    @auction.bid("Joe", 15.00)
  end
end
