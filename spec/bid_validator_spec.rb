require_relative '../domain/bid_validator'

describe AuctionHouse::BidValidator do
  before(:each) do
    @bid_listener = double('bid listener')
    @bid_processor = double('bid processor')
    @bid_validator = AuctionHouse::BidValidator.new(@bid_processor, @bid_listener)
  end

  it "reports a successful bid when it is the first bid" do
    @bid_listener.should_receive(:bid_successful)
    @bid_processor.should_receive(:bid).with("Joe", 15.00)

    @bid_validator.bid("Joe", 15.00)
  end

  it "reports the bid was not successful when a bid arrives that is less than the current max bid" do
    @bid_listener.should_receive(:bid_failed)

    @bid_validator.auction_state_updated(AuctionHouse::AuctionState.new("Joe", 15.00))
    @bid_validator.bid("Jane", 14.50)
  end
end