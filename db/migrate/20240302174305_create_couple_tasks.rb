class CreateCoupleTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :couple_tasks do |t|
      t.references :couple_challenge, null: false, foreign_key: true
      t.references :couple, null: false, foreign_key: true
      t.date :completion_date
      t.boolean :active
      t.boolean :completed
      t.string :date_option_1
      t.date :date_option_2
      t.date :date_option_3

      t.timestamps
    end
  end
end
