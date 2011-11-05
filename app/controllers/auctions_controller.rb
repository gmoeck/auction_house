class AuctionsController < ApplicationController
  def show
    params[:type] = 'show'
    AuctionHouse::Domain.auction_request_translator.process_request(params)
    @view_model = AuctionHouse::Domain.auction_view_model
  end

  def update
    params[:type] = 'update'
    AuctionHouse::Domain.auction_request_translator.process_request(params)
    @view_model = AuctionHouse::Domain.auction_view_model
    render :action => :show
  end
end
