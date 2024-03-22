class AddCurrentChatroomToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :current_chatroom, foreign_key: { to_table: :chatrooms, on_delete: :nullify }, index: true
  end
end
