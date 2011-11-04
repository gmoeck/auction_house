class Auction
  attr_accessor :highest_bidder, :max_bid

  def initialize(params={})
    @highest_bidder = params[:highest_bidder]
    @max_bid = params[:max_bid]
  end
end

class AuctionsController < ApplicationController
  def show
    @auction = Auction.new
  end

  def update
    @auction = Auction.new(:highest_bidder => params[:bidder], :max_bid => params[:maximum_bid])
    render :action => :show
  end
end
