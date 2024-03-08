class AddMissionCountToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :mission_count, :integer, default: 0
  end
end
