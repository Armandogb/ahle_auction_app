class Auction < ApplicationRecord
  has_and_belongs_to_many :sections
  has_many :items, through: :sections
  validates :name, uniqueness: true

end
