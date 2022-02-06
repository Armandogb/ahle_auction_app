class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check, except: %i[ ajax_create_bid ]

  def ajax_create_bid
    @item = Item.find(params[:item_id])
    @user = User.find(params[:user_id])
    @end_time = @item.sections.first.end_time
    time = DateTime.now
    bid = params[:bid].to_i
    result = {}

    if time > @end_time
      result[:status] = 'closed'
      result[:message] = "Bidding on this Item has ended."
    else
      @item.with_lock do
        @item.save!
        bid_logic = @item.bid_values

        if bid >= bid_logic[:valid_bid].to_i
          out_bidded = bid_logic[:high_bid_object]
          @bid = Bid.create(user_id: @user.id, item_id: @item.id, value: bid)

          unless out_bidded.nil?
            out_bidded = Bid.find(bid_logic[:high_bid_object])
            o_user = out_bidded.user
            unless out_bidded.user == @user
              o_user.send_text_message('outbid', @item)
            end
          end
          result[:status] = 'ok'
          result[:message] = "Your bid is the highest bid!"
          result[:valid_bid] = bid + @item.min_bid
          result[:highest] = bid
        else
          result[:status] = 'outbid'
          result[:message] = "You have been outbid, raise your bid to $#{bid_logic[:valid_bid]}."
          result[:valid_bid] = bid_logic[:valid_bid]
          result[:highest] = bid_logic[:high_bid]
        end
      end
    end

    respond_to do |format|

      format.html {
      }
      format.json {
        render json: result
      }

    end

  end


  private

    # Only allow a list of trusted parameters through.
    def bid_params
      params.require(:item).permit!
    end
end
