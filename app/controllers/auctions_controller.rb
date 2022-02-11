class AuctionsController < ApplicationController
  before_action :authenticate_user!, except: %i[ auction_timer ]
  before_action :admin_check, except: %i[ index my_items_index auction_timer]
  before_action :set_auction, only: %i[ show edit update destroy ]
  layout "auction_timer_layout", only: [ :auction_timer ]

  # GET /auctions or /auctions.json
  def index
    @auction = Auction.active_auction
    @sections = @auction.active_sections
    gon.timers = @auction.create_js_time_array
    @user = current_user
  end

  def auction_timer
    @auction = Auction.active_auction
    @sections = @auction.sections
    gon.timers = @auction.create_js_time_array
  end

  def admin_index
    @auctions = Auction.all
    @sections = Section.all
    @items = Item.all
  end

  def my_items_index
    @items_col = @user.items.uniq
    @items = []
    results = []

    @items_col.each do |i|
      unless i.section_q.nil?
        results << i.create_js_time_array
        @items << i
      end
    end
    gon.timers = results

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
