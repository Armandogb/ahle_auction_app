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


  private

  def check_sign_up_code

    case self.sign_up_code
    when ENV["SU_NORMAL"].to_s, ENV["SU_ADMIN"].to_s
      if self.sign_up_code == ENV["SU_ADMIN"].to_s
        @set_admin = true
      else
        @set_admin = false
      end
    else
      errors.add(:sign_up_code,
                 "Invalid.")
    end
  end

end
