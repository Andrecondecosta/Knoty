class Event < ApplicationRecord
  belongs_to :couple
  belongs_to :user
  validates :name, presence: true
  validates :details, presence: true
  validates :date, presence: true
  validates :location, presence: true
end
