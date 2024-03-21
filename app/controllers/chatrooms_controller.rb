class ChatroomsController < ApplicationController
  def show
    @message = Message.new
  end
end
