class Auction < ApplicationRecord
  validates :name, uniqueness: true
end
