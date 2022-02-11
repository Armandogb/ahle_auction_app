class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def format_date
    self.created_at.strftime("%m/%d/%Y %I:%M %p")
  end

  def dollar_value
    ActionController::Base.helpers.number_to_currency(self.value)
  end

  def bid_label
    usr = self.user
    itm = self.item
    "#{itm.name} - #{usr.first_name} #{usr.last_name} - #{usr.human_phone} - #{self.dollar_value} - #{self.format_date}"
  end

end
