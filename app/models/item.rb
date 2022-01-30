class Item < ApplicationRecord
  has_and_belongs_to_many :sections
  has_many :bids
  mount_uploader :photo, ItemPicUploader

  def bid_values
    bids = self.bids
    results = {
        high_bid: 0,
        valid_bid: 0
    }

    if bids.empty?
      start_bid = self.min_bid + self.starting_bid
      results[:valid_bid] = start_bid
    else
      results[:high_bid] = bids.order(value: :desc).first.value
      results[:valid_bid] = results[:high_bid] + self.min_bid
    end

    return results

  end

end
