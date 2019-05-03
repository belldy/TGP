class PrivateMessage < ApplicationRecord
  belongs_to :sender, class_name: "User"
  has_many :message_recipients
  has_many :users, through: :message_recipients
end
