require_relative '../domain/web/auction_view_model'

describe AuctionHouse::WebAuctionViewModel do
  before(:each) do
    @view_model = AuctionHouse::WebAuctionViewModel.new
  end

  context 'when no bids have taken place' do
    subject { @view_model }

    its(:highest_bidder)      { should be_empty }
    its(:max_bid)             { should == 0.0 }
    its(:status_message)      { should be_empty }
    its(:has_status_message?) { should be_false }
  end

  describe "when the view model is notified of a successful bid" do
    before { @view_model.bid_successful }

    subject { @view_model }

    its(:status_message)      { should == "Bid Accepted. You are now the highest bidder." }
    its(:has_status_message?) { should be_true }
  end

  describe "when the view model is notified of a failed bid" do
    before { @view_model.bid_failed }

    subject { @view_model }

    its(:status_message)      { should == "Bid Failed." }
    its(:has_status_message?) { should be_true }
  end

  describe "when the view model is notified of the auction state changing" do
    let(:new_high_bidder) { "Joe" }
    let(:new_max_bid) { 15.00 }
    let(:new_highest_bid) { AuctionHouse::Bid.new(new_high_bidder, new_max_bid) }
    before { @view_model.highest_bid_updated(new_highest_bid) }
    subject { @view_model }

    its(:highest_bidder) { should == new_high_bidder }
    its(:max_bid)        { should == new_max_bid }
  end
end

