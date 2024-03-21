class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :couple

  validates_uniqueness_of :couple_id
end
