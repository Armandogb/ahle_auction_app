class Auction < ApplicationRecord
  has_and_belongs_to_many :sections
  has_many :items, through: :sections
  validates :name, uniqueness: true

  def active_sections
    return self.sections.where(active: true).where("end_time > ?", DateTime.now ).order(end_time: :asc)
  end

  def create_js_time_array
    sects = self.active_sections
    results = []

    sects.each do |s|
      results << [s.id, s.js_date_string]
    end

    return results
  end


end
