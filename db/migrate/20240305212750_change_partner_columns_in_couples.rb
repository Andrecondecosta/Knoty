class ChangePartnerColumnsInCouples < ActiveRecord::Migration[7.1]
  def change
  rename_column :couples, :partner_1_id, :partner1_id
  rename_column :couples, :partner_2_id, :partner2_id
  end
end
