class CreateCouples < ActiveRecord::Migration[7.1]
  def change
    create_table :couples do |t|
      t.references :partner_1, null: false, foreign_key: { to_table: :users }
      t.references :partner_2, null: false, foreign_key: { to_table: :users }
      t.date :relation_since
      t.integer :total_exp

      t.timestamps
    end
  end
end
