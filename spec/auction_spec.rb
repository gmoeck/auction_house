require_relative '../domain/auction'

describe AuctionHouse::Auction do
  before(:each) do
    @auction_listener = double('auction listener')
    @auction = AuctionHouse::Auction.new
    @auction.add_listener(@auction_listener)
  end

  it "reports the bid was successful when the first bid arrives" do
    @auction_listener.should_receive(:highest_bid_updated).with(AuctionHouse::Bid.new("Joe", 15.00))

    @auction.bid("Joe", 15.00)
  end

  it "reports that the bid was successful and increments the minimum bid amount when new bid that is higher than the current max bid comes in" do
    @auction_listener.should_receive(:highest_bid_updated).with(AuctionHouse::Bid.new("Joe", 15.00)).ordered
    @auction_listener.should_receive(:highest_bid_updated).with(AuctionHouse::Bid.new("Jane", 15.50)).ordered

    @auction.bid("Joe", 15.00)
    @auction.bid("Jane", 20.00)
  end

  it "reports to all of it's listeners" do
    @auction_listener2 = double('a second auction listener')
    @auction.add_listener(@auction_listener2)

    @auction_listener.should_receive(:highest_bid_updated).with(AuctionHouse::Bid.new("Joe", 15.00))
    @auction_listener2.should_receive(:highest_bid_updated).with(AuctionHouse::Bid.new("Joe", 15.00))

    @auction.bid("Joe", 15.00)
  end
end
