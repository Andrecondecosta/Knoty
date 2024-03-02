class AddLoveLanguageForeignKeyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :love_language, null: false, foreign_key: true
  end
end
