class ChatroomsController < ApplicationController
  before_action :set_notifications_to_read, only: :show
  before_action :set_partner, only: :show

  def show

    @messages = @chatroom.messages.order(created_at: :asc)
    @message = Message.new
  end

  private

  def set_notifications_to_read
    notifications = current_user.notifications.unread
    notifications.update_all(read_at: Time.zone.now)
  end

  def set_partner
    return unless signed_in?

    @partner = @couple.partner_1 == current_user ? @couple.partner_2 : @couple.partner_1
  end
end
