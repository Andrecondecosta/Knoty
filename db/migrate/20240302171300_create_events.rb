class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :details
      t.string :location
      t.date :date
      t.references :couple, null: false, foreign_key: true
      t.boolean :is_memory

      t.timestamps
    end
  end
end
