class CreateMissions < ActiveRecord::Migration[7.1]
  def change
    create_table :missions do |t|
      t.string :title
      t.text :details
      t.string :icon
      t.integer :exp
      t.references :user, null: false, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
