class CreateLoveLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :love_languages do |t|
      t.integer :acts_of_service
      t.integer :words_of_affirmation
      t.integer :receiving_gifts
      t.integer :quality_time
      t.integer :physical_touch

      t.timestamps
    end
  end
end
