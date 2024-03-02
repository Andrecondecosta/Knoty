class IndividualTask < ApplicationRecord
  belongs_to :user
  belongs_to :individual_challenge
end
