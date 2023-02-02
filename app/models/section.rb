class Section < ApplicationRecord
  has_many :items
  belongs_to :auction
  after_create :set_alerts


  def self.text_alert_times
    %i[two_minute_text_sent five_minute_text_sent ten_minute_text_sent]
  end

  store_accessor :text_alerts, Section.text_alert_times

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

  def self.send_timer_texts(entity)
    
    account_sid = ENV["TWL_SID"]
    auth_token = ENV["TWL_AUTH"]
    from_number = ENV["TWL_NUM"]
    home_url = ENV["HOME_URL"]
    phone_numbers = User.all.pluck(:phone)

    msg = "#{entity[:display_name]} will be ending in less than #{entity[:time_left]} Minutes! #{home_url} ".squish

    rest_client = Twilio::REST::Client.new account_sid, auth_token

    request_timer = 0

    phone_numbers.each do|phone|
      to_phone = phone
      begin
        response = rest_client.messages.create(from: from_number, to: '+1' + to_phone, body: msg)

      rescue Twilio::REST::RestError => e
        message = e.message

        puts "#{message}"
      end

      request_timer += 1

      if request_timer == 45
        request_timer = 0 
        sleep 1
      end

    end

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

  private

  def set_alerts
    Section.text_alert_times.each do |alert|
      self[:text_alerts][alert.to_sym] = false
    end
    self.save
  end

end