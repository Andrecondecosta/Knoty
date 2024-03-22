class ChatroomsController < ApplicationController
  after_action :set_notifications_to_read, only: :show

  def show
    @message = Message.new
  end

  private

  def set_notifications_to_read
    notifications = current_user.notifications.unread
    notifications.update_all(read_at: Time.zone.now)
  end
end
