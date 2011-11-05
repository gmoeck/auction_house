require_relative '../domain/web/auction_view_model'

describe AuctionHouse::WebAuctionViewModel do
  before(:each) do
    @response = AuctionHouse::WebAuctionViewModel.new
  end

  context 'when no bids have taken place' do
    subject { @response }

    its(:highest_bidder)      { should be_empty }
    its(:max_bid)             { should == 0.0 }
    its(:status_message)      { should be_empty }
    its(:has_status_message?) { should be_false }
  end

  describe "when the response is notified of a successful bid" do
    let(:current_high_bidder) { "Joe" }
    let(:current_max_bid)     { 15.00 }
    before { @response.bid_successful(AuctionHouse::AuctionState.new(current_high_bidder, current_max_bid)) }

    subject { @response }

    its(:highest_bidder) { should == current_high_bidder }
    its(:max_bid)        { should == current_max_bid }
    its(:status_message) { should == "Bid Accepted. You are now the highest bidder." }
    its(:has_status_message?) { should be_true }
  end

  describe "when the response is notified of a failed bid" do
    let(:current_high_bidder) { "Joe" }
    let(:current_max_bid)     { 15.00 }
    before { @response.bid_failed(AuctionHouse::AuctionState.new(current_high_bidder, current_max_bid)) }

    subject { @response }

    its(:highest_bidder) { should == current_high_bidder }
    its(:max_bid)        { should == current_max_bid }
    its(:status_message) { should == "Bid Failed." }
    its(:has_status_message?) { should be_true }
  end
end

