class AuctionsController < ApplicationController
  def show
    params[:type] = 'show'
    AuctionHouse::Domain.auction_request_translator.process_request(params)
    @auction = AuctionHouse::Domain.auction_response
  end

  def update
    params[:type] = 'update'
    AuctionHouse::Domain.auction_request_translator.process_request(params)
    @auction = AuctionHouse::Domain.auction_response
    render :action => :show
  end
end
