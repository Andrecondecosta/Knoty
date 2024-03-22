class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  validates :content, presence: true

  def sender?(a_user)
    user.id == a_user.id
  end

  def message_date
    created_at.strftime("%B %e")
  end
end
