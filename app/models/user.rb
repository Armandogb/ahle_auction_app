class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bids
  attr_accessor :email_confirmation

  before_save :encrpyt_fields

  def decrpyt_fields
    create_crypt

    self.cn =  @crypt.decrypt_and_verify(self.cn) unless self.cn.nil?
    self.cm =  @crypt.decrypt_and_verify(self.cm) unless self.cm.nil?
    self.cy =  @crypt.decrypt_and_verify(self.cy) unless self.cy.nil?
    self.cp =  @crypt.decrypt_and_verify(self.cp) unless self.cp.nil?
    self.cz =  @crypt.decrypt_and_verify(self.cz) unless self.cz.nil?
    self.ct =  @crypt.decrypt_and_verify(self.ct) unless self.ct.nil?
  end

  private

  def encrpyt_fields
    create_crypt

    self.cn =  @crypt.encrypt_and_sign(self.cn) unless self.cn.nil?
    self.cm =  @crypt.encrypt_and_sign(self.cm) unless self.cm.nil?
    self.cy =  @crypt.encrypt_and_sign(self.cy) unless self.cy.nil?
    self.cp =  @crypt.encrypt_and_sign(self.cp) unless self.cp.nil?
    self.cz =  @crypt.encrypt_and_sign(self.cz) unless self.cz.nil?
    self.ct =  @crypt.encrypt_and_sign(self.ct) unless self.ct.nil?
  end


end
