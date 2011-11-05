require_relative '../domain/auction'

describe AuctionHouse::Auction do
  before(:each) do
    @auction_listener = double('auction listener')
    @auction = AuctionHouse::Auction.new(@auction_listener)
  end

  it "reports the bid was successful when the first bid arrives" do
    @auction_listener.should_receive(:bid_successful).with(AuctionHouse::AuctionState.new("Joe", 15.00))

    @auction.bid("Joe", 15.00)
  end

  it "reports the bid was not successful when a bid arrives that is less than the current max bid" do
    @auction_listener.should_receive(:bid_successful).with(AuctionHouse::AuctionState.new("Joe", 15.00)).ordered
    @auction_listener.should_receive(:bid_failed).with(AuctionHouse::AuctionState.new("Joe", 15.00)).ordered

    @auction.bid("Joe", 15.00)
    @auction.bid("Jane", 14.50)
  end
end

