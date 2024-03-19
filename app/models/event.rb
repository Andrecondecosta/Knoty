class Event < ApplicationRecord
  belongs_to :couple
  belongs_to :user
end
