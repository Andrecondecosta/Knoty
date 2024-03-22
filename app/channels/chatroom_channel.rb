class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    chatroom = Chatroom.find(params[:id])
    current_user&.update(current_chatroom: chatroom)

    stream_for chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.update(current_chatroom: nil)
  end
end
