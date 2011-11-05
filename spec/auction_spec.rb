require_relative '../domain/auction'

describe AuctionHouse::Auction do
  before(:each) do
    @auction_listener = double('auction listener')
    @auction = AuctionHouse::Auction.new(@auction_listener)
  end

  it "reports the bid was successful when the first bid arrives" do
    @auction_listener.should_receive(:bid_successful)
    @auction_listener.should_receive(:auction_state_updated).with(AuctionHouse::AuctionState.new("Joe", 15.00))

    @auction.bid("Joe", 15.00)
  end

  it "reports the bid was not successful when a bid arrives that is less than the current max bid" do
    @auction_listener.should_receive(:bid_successful)
    @auction_listener.should_receive(:auction_state_updated).with(AuctionHouse::AuctionState.new("Joe", 15.00)).ordered
    @auction_listener.should_receive(:bid_failed)

    @auction.bid("Joe", 15.00)
    @auction.bid("Jane", 14.50)
  end

  it "reports that the bid was successful and increments the minimum bid amount when new bid that is higher than the current max bid comes in" do
    @auction_listener.should_receive(:bid_successful).twice
    @auction_listener.should_receive(:auction_state_updated).with(AuctionHouse::AuctionState.new("Joe", 15.00)).ordered
    @auction_listener.should_receive(:auction_state_updated).with(AuctionHouse::AuctionState.new("Jane", 15.50)).ordered

    @auction.bid("Joe", 15.00)
    @auction.bid("Jane", 20.00)
  end
end
