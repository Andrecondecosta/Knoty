class CreateFortunes < ActiveRecord::Migration[7.1]
  def change
    create_table :fortunes do |t|
      t.string :title
      t.text :details

      t.timestamps
    end
  end
end
