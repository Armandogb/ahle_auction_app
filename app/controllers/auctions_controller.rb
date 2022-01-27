class AuctionsController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_check
  before_action :set_auction, only: %i[ show edit update destroy ]

  # GET /auctions or /auctions.json
  def index
    @auctions = Auction.where(active: true).last
    @sections = @auctions.sections
  end

  def admin_index
    @auctions = Auction.all
    @sections = Section.all
    @items = Item.all
  end

  # GET /auctions/1 or /auctions/1.json
  def show
  end

  # GET /auctions/new
  def new
    @auction = Auction.new
  end

  # GET /auctions/1/edit
  def edit
  end

  # POST /auctions or /auctions.json
  def create
    @auction = Auction.new(auction_params)

    if @auction.save
      redirect_to admin_index_path, notice: "Auction was successfully created."
    else
      render :new, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /auctions/1 or /auctions/1.json
  def update
    if @auction.update(auction_params)
      redirect_to admin_index_path, notice: "Auction was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /auctions/1 or /auctions/1.json
  def destroy
    @auction.destroy

    redirect_to admin_index_path, notice: "Auction was successfully destroyed."

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def auction_params
      params.require(:auction).permit!
    end
end
