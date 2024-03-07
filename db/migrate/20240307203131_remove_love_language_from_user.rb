class RemoveLoveLanguageFromUser < ActiveRecord::Migration[7.1]
  def change
    remove_reference :users, :love_language, null: false, foreign_key: true
    add_reference :love_languages, :user, null: false, foreign_key: true
  end
end
