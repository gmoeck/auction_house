require_relative '../domain/bid_calculator'

describe AuctionHouse::BidCalculator do
  before(:each) do
    @bid_processor = double('bid processor')
    @bid_calculator = AuctionHouse::BidCalculator.new(@bid_processor)
  end

  it "bids whatever the maximum bid that was offered when no bids have yet been made" do
    @bid_processor.should_receive(:bid).with("Joe", 15.00)

    @bid_calculator.bid("Joe", 15.00)
  end

  it "bids 0.05 over the current price when the current price is between 0.01 and 0.99" do
    @current_bid_amount = 0.01
    @increment = 0.05
    @bid_calculator.highest_bid_updated(AuctionHouse::Bid.new("Jane", @current_bid_amount))
    @bid_processor.should_receive(:bid).with("Joe", @current_bid_amount + @increment)

    @bid_calculator.bid("Joe", nil)
  end

  it "bids 0.25 over the current price when the current price is between 1.00 and 4.99" do
    @current_bid_amount = 1.00
    @increment = 0.25
    @bid_calculator.highest_bid_updated(AuctionHouse::Bid.new("Jane", @current_bid_amount))
    @bid_processor.should_receive(:bid).with("Joe", @current_bid_amount + @increment)

    @bid_calculator.bid("Joe", nil)
  end

  it "bids 0.50 over the current price when the current price is between 5.00 and 24.99" do
    @current_bid_amount = 18.00
    @increment = 0.50
    @bid_calculator.highest_bid_updated(AuctionHouse::Bid.new("Jane", @current_bid_amount))
    @bid_processor.should_receive(:bid).with("Joe", @current_bid_amount + @increment)

    @bid_calculator.bid("Joe", nil)
  end

  it "bids 1.00 over the current price for anything at or above 25.00" do
    @current_bid_amount = 27.00
    @increment = 1.00
    @bid_calculator.highest_bid_updated(AuctionHouse::Bid.new("Jane", @current_bid_amount))
    @bid_processor.should_receive(:bid).with("Joe", @current_bid_amount + @increment)

    @bid_calculator.bid("Joe", nil)
  end
end
