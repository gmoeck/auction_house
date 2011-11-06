require_relative '../domain/maximum_bid_tracker'

describe AuctionHouse::MaximumBidTracker do
  before(:each) do
    @bid_processor = double('bid processor')
    @bid_calculator = AuctionHouse::MaximumBidTracker.new(@bid_processor)
  end

  it "bids whatever the maximum bid that was offered when no bids have yet been made" do
    @bid_processor.should_receive(:bid).with("Joe", 15.00)

    @bid_calculator.bid("Joe", 15.00)
  end

  it "bids exactly the maximum offered when the maximum offered is more than the current bid, but less than the minimum increment" do
    @bid_processor.should_receive(:bid).with("Joe", 15.00)
    @bid_processor.should_receive(:bid).with("Jane", 15.01)

    @bid_calculator.bid("Joe", 15.00)
    @bid_calculator.bid("Jane", 15.01)
  end

  it "bids only the minimum increment over the current bid when a different person bids higher than the current bid" do
    @bid_processor.should_receive(:bid).with("Joe", 15.00)
    @bid_processor.should_receive(:bid).with("Jane", 15.50)

    @bid_calculator.bid("Joe", 15.00)
    @bid_calculator.bid("Jane", 20.00)
  end

  it "bids the minimum increment over the current max bid when a different person bids higher than the current max bid" do
    @bid_processor.should_receive(:bid).with("Joe", 15.00)
    @bid_processor.should_receive(:bid).with("Jane", 15.50)
    @bid_processor.should_receive(:bid).with("Joe", 20.50)

    @bid_calculator.bid("Joe", 15.00)
    @bid_calculator.bid("Jane", 20.00)
    @bid_calculator.bid("Joe", 25.00)
  end

  it "rebids for the person who has a max offer if an offer is made that is less than the max offer, but more than the current offer" do
    @bid_processor.should_receive(:bid).with("Joe", 15.00).ordered
    @bid_processor.should_receive(:bid).with("Jane", 15.50).ordered
    @bid_processor.should_receive(:bid).with("Joe", 20.00).ordered
    @bid_processor.should_receive(:bid).with("Jane", 20.50).ordered

    @bid_calculator.bid("Joe", 15.00)
    @bid_calculator.bid("Jane", 40.00)
    @bid_calculator.bid("Joe", 20.00)
  end
end
