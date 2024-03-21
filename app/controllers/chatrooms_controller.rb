class ChatroomsController < ApplicationController
  before_action :set_couple, only: %i[show]

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  private

  def set_couple
    return unless signed_in?

    @couple = current_user.couple_as_partner_1 || current_user.couple_as_partner_2
  end
end
