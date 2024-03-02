class CreateIndividualTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :individual_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :individual_challenge, null: false, foreign_key: true
      t.boolean :active
      t.boolean :completed
      t.date :date

      t.timestamps
    end
  end
end
