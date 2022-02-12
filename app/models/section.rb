class Section < ApplicationRecord
  has_and_belongs_to_many :items

  def js_date_string
    return self.end_time.strftime("%m/%d/%Y %H:%M:%S")
  end

  def view_date_string
    return self.end_time.strftime("%m/%d/%Y %I:%M %p")
  end

  def time_expired?
    time_now = DateTime.now
    self.end_time <time_now
  end

  def selectable_items
    all_items = Item.where(active: true)
    item_ids = all_items.pluck(:id)
    other_section_item_ids = []
    sections = Section.all

    sections.each do |section|
      section.items.each do |item|
        unless section.id == self.id
          other_section_item_ids << item.id
        end
      end
    end

    return all_items.where(id: item_ids - other_section_item_ids).order(:name)
  end

end