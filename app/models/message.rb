class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  validates_presence_of :content

  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  after_create :notify_partner

  private

  def notify_partner
    couple = user.couple_as_partner_1 || user.couple_as_partner_2
    partner = couple.partner_1 == user ? couple.partner_2 : couple.partner_1
    notification = MessageNotifier.with(record: self)
    notification.deliver_later(partner)
    partner.notifications.update_all(read_at: Time.zone.now) unless partner.current_chatroom.nil?
    NotificationsChannel.broadcast_to(partner, partner.notifications.unread.count)
  end

  def sender?(a_user)
    user.id == a_user.id
  end

  def message_date
    created_at.strftime("%B %e")
  end
end
