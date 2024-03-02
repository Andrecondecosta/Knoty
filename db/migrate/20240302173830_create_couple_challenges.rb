class CreateCoupleChallenges < ActiveRecord::Migration[7.1]
  def change
    create_table :couple_challenges do |t|
      t.string :title
      t.text :details
      t.integer :difficulty
      t.integer :estimated_time
      t.string :prompt_1
      t.string :prompt_2
      t.integer :exp

      t.timestamps
    end
  end
end
