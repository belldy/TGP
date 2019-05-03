class City < ApplicationRecord
  has_many :users
  has_many :gossips, through: :users

  validates :name, 
    presence: true
  validates :zip_code,
    presence: true
end
