class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :couple
  has_many :users

  validates_uniqueness_of :couple_id

end
