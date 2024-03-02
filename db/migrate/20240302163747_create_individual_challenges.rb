class CreateIndividualChallenges < ActiveRecord::Migration[7.1]
  def change
    create_table :individual_challenges do |t|
      t.string :title
      t.text :details
      t.integer :estimated_time
      t.integer :difficulty
      t.string :prompt
      t.integer :exp

      t.timestamps
    end
  end
end
