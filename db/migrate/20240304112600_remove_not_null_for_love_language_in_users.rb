class RemoveNotNullForLoveLanguageInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :love_language_id, true
  end
end
