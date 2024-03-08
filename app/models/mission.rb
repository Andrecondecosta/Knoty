class Mission < ApplicationRecord
  belongs_to :user
  validates :icon, :title, :details, presence: true
  after_initialize :set_default_icon, if: :new_record?

  private

  def set_default_icon
    self.icon ||= "https://res.cloudinary.com/dvgcwuo68/image/upload/v1709838344/clipboard-list-solid_wrk3r2.png"
  end
end
