class Section < ApplicationRecord
  has_and_belongs_to_many :items

  def js_date_string
    return self.end_time.strftime("%m/%d/%Y %H:%M:%S")
  end

  def view_date_string
    return self.end_time.strftime("%m/%d/%Y %I:%M %p")
  end

end