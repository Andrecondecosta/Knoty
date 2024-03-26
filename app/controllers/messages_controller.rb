class MessagesController < ApplicationController
  before_action :set_partner, only: %i[create]

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        message: render_to_string(partial: "message", locals: { message: @message }),
        date: @message.created_at.strftime("%B %e"),
        sender_id: @message.user.id
      )
      head :ok
    else
      render "chatrooms/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_partner
    return unless signed_in? && @couple

    @partner = @couple.partner_1 == current_user ? @couple.partner_2 : @couple.partner_1
  end
end
