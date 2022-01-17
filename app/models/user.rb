class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :encrpyt_fields

  def decrpyt_fields
    create_crypt

  end

  private

  def encrpyt_fields
    create_crypt

  end


end
