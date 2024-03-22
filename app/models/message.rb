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
    NotificationsChannel.broadcast_to(partner, partner.notifications.unread.count)
  end
end
