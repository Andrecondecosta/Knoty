class Event < ApplicationRecord

  belongs_to :couple
  belongs_to :user
  validates_presence_of :name, :details, :date

  has_one_attached :image

end
