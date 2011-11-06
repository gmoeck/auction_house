module AuctionHouse
  class MaximumBidTracker
    def initialize(bid_processor)
      @state = NoBidsState.new(bid_processor)
    end

    def bid(bidder, max_offer)
      @state = @state.bid(bidder, max_offer, increment)
    end

    def increment
      0.5
    end

    class NoBidsState
      def initialize(bid_processor)
        @bid_processor = bid_processor
      end

      def bid(bidder, max_offer, increment)
        @bid_processor.bid(bidder, max_offer)
        CurrentBidIsMaxOfferState.new(@bid_processor, max_offer)
      end
    end

    class CurrentBidIsMaxOfferState
      def initialize(bid_processor, current_bid)
        @bid_processor = bid_processor
        @current_bid = current_bid
      end

      def bid(bidder, max_offer, increment)
        if max_offer < @current_bid + increment
          @bid_processor.bid(bidder, max_offer)
          CurrentBidIsMaxOfferState.new(@bid_processor, max_offer)
        else
          @bid_processor.bid(bidder, @current_bid + increment)
          CurrentBidIsLessThanMaxOfferState.new(@bid_processor, @current_bid + increment, max_offer, bidder)
        end
      end
    end

    class CurrentBidIsLessThanMaxOfferState
      def initialize(bid_processor, current_bid, current_max_offer, current_max_bidder)
        @bid_processor = bid_processor
        @current_bid = current_bid
        @current_max_offer = current_max_offer
        @current_max_bidder = current_max_bidder
      end

      def bid(bidder, max_offer, increment)
        if @current_max_offer < max_offer
          @bid_processor.bid(bidder, @current_max_offer + increment)
          CurrentBidIsLessThanMaxOfferState.new(@bid_processor, @current_max_offer + increment, max_offer, bidder)
        else
          @bid_processor.bid(bidder, max_offer)
          @bid_processor.bid(@current_max_bidder, max_offer + increment)
          CurrentBidIsLessThanMaxOfferState.new(@bid_processor, max_offer + increment, @current_max_offer, @current_max_bidder)
        end
      end
    end
  end
end
