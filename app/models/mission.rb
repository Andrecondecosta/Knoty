class Mission < ApplicationRecord
  belongs_to :user
  validates :icon, :title, presence: true
  after_initialize :set_default_icon, if: :new_record?

  private

  def set_default_icon
    self.icon ||= "https://res.cloudinary.com/dvgcwuo68/image/upload/v1711398800/to-do-list_v0d8nl.png"
  end
end
