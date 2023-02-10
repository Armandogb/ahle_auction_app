class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bids
  has_many :items, through: :bids
  attr_accessor :email_confirmation, :sign_up_code

  before_validation :check_sign_up_code
  after_create :final_steps


  def send_text_message(message,entity)

    account_sid = ENV["TWL_SID"]
    auth_token = ENV["TWL_AUTH"]
    from_number = ENV["TWL_NUM"]
    bidded_auctions = ENV["MY_BID_URL"]

    case message
    when 'welcome'
      msg = "Welcome to the AHLE Auction! You will recieve text updates on the items you bid on.".squish
    when 'outbid'
      msg = "You've been outbid! They bid #{entity[:bid]} on #{entity[:item_name]}! Click #{bidded_auctions} to view your bidded on items to rebid!".squish
    when 'high_bid'
      msg = "You are the highest bidder on #{entity[:item_name]} with a #{entity[:bid]} bid!".squish
    when 'winner'
      msg = "You Won #{entity[:item_name]} with a #{entity[:winning_bid]} bid! Go claim your prize!".squish
    when 'time'
      msg = "#{entity[:display_name]} will be ending in less than #{entity[:time_left]} Minutes!".squish
    end

    to_phone = self.phone

    rest_client = Twilio::REST::Client.new account_sid, auth_token

      begin
        response = rest_client.messages.create(from: from_number, to: '+1' + to_phone, body: msg)

      rescue Twilio::REST::RestError => e
        message = e.message

        puts "#{message}"
      end

  end

  def human_phone
    return  ActionController::Base.helpers.number_to_phone(self.phone, area_code: true)
  end


  private

  def check_sign_up_code
    admin_code = ENV["SU_ADMIN"].to_s.downcase.squish
    user_code = self.sign_up_code.downcase.squish

    case user_code
      when admin_code
        @set_admin = true
      else
        @set_admin = false
    end
  end

  def final_steps
    if @set_admin
      self.add_role(:admin)
    end

    self.send_text_message('welcome', nil)
  end

end
