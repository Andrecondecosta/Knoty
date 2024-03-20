class ChangeTotalExpInCouples < ActiveRecord::Migration[7.1]
  def change
    change_column_default :couples, :total_exp, 0
  end
end
