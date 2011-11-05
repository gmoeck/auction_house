require_relative '../domain/web/auction_response'

describe AuctionHouse::WebAuctionResponse do
  before(:each) do
    @response = AuctionHouse::WebAuctionResponse.new
  end

  describe "when the response is notified of a successful bid" do
    let(:current_high_bidder) { "Joe" }
    let(:current_max_bid)     { 15.00 }
    before { @response.bid_successful(AuctionHouse::AuctionState.new(current_high_bidder, current_max_bid)) }

    subject { @response }

    its(:highest_bidder) { should == current_high_bidder }
    its(:max_bid)        { should == current_max_bid }
  end

  describe "when the response is notified of a failed bid" do
    let(:current_high_bidder) { "Joe" }
    let(:current_max_bid)     { 15.00 }
    before { @response.bid_failed(AuctionHouse::AuctionState.new(current_high_bidder, current_max_bid)) }

    subject { @response }

    its(:highest_bidder) { should == current_high_bidder }
    its(:max_bid)        { should == current_max_bid }
  end
end

