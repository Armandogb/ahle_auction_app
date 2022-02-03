class Auction < ApplicationRecord
  has_and_belongs_to_many :sections
  has_many :items, through: :sections
  validates :name, uniqueness: true

  def active_sections
    sects = self.sections

    if sects.empty?
      sects = nil
    else
      sects = sects.where(active: true).where("end_time > ?", DateTime.now ).order(end_time: :asc)
    end

    return sects
  end

  def create_js_time_array
    sects = self.active_sections
    results = []

    unless sects.empty?
      sects.each do |s|
        results << [s.id, s.js_date_string]
      end
    end

    return results
  end

  def self.active_auction
    auction = Auction.where(active: true)

    if auction.empty?
      auction = Auction.new
    else
      auciton = auciton.last
    end

    return auction
  end


end
