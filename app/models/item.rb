class Item < ApplicationRecord
  belongs_to :section
  has_many :bids
  mount_uploader :photo, ItemPicUploader

  validates :photo, presence: true

  def bid_values(user)
    bids = self.bids
    results = {
        high_bid: 0,
        valid_bid: 0,
        high_bid_object: nil,
        bidder: nil
    }

    if bids.empty?
      start_bid = self.min_bid + self.starting_bid
      results[:valid_bid] = start_bid
    else
      hb = self.highest_bid
      hb_user = hb.user
      results[:high_bid_object] = hb.id
      results[:high_bid] = hb.value
      results[:valid_bid] = results[:high_bid] + self.min_bid
      if hb_user == user
        results[:bidder] = "You"
      else
        results[:bidder] = hb_user.first_name
      end
    end

    return results

  end

  def section_q
    self.section
  end

  def section_label
    sect = self.section

    if sect.present?
      return sect.display_name
    else
      return "No Section"
    end
  end

  def create_js_time_array
    sects = self.section_q

    results = [sects.id, sects.js_date_string]

    return results
  end

  def highest_bid
    bid = self.bids

    if bid.empty?
      bid = []
    else
      bid = bid.order(value: :desc).first
    end

    return bid
  end


end
