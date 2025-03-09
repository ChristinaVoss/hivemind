class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :hive, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true # , format: { with: URI::MailTo::EMAIL }
  validates :password, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  BEE_SPEED_TO_HIVE = 17.0 # km/h
  BEE_SPEED_TO_FOOD = 28.0 # km/h
end
