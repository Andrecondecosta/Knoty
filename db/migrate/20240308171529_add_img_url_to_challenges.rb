class AddImgUrlToChallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :couple_challenges, :img_url, :string
    add_column :individual_challenges, :img_url, :string
  end
end
