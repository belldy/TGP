class Gossip < ApplicationRecord

  validates :title,
    presence: true, 
    length: { in: 3..14 }

  validates :content,
    presence: true


  belongs_to :user
  has_many :gossip_tags
  has_many :tags, through: :gossip_tags
  has_many :likes
  has_many :users, through: :likes
end
