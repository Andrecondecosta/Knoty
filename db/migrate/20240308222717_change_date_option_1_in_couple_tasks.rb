class ChangeDateOption1InCoupleTasks < ActiveRecord::Migration[7.1]
  def change
    remove_column :couple_tasks, :date_option_1
    add_column :couple_tasks, :date_option_1, :date
  end
end
