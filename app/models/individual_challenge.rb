class IndividualChallenge < ApplicationRecord
  has_many :individual_tasks, dependent: :destroy
end
