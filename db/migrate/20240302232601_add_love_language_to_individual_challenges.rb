class AddLoveLanguageToIndividualChallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :individual_challenges, :acts_of_service, :boolean, default: false
    add_column :individual_challenges, :words_of_affirmation, :boolean, default: false
    add_column :individual_challenges, :physical_touch, :boolean, default: false
    add_column :individual_challenges, :quality_time, :boolean, default: false
    add_column :individual_challenges, :receiving_gifts, :boolean, default: false
  end
end
