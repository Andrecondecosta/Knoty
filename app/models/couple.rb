class Couple < ApplicationRecord
  belongs_to :partner1, class_name: 'User'
  belongs_to :partner2, class_name: 'User'

  validate :different_partners

  private

  def different_partners
    if partner1 == partner2
      errors.add(:base, "Partner 1 and Partner 2 cannot be the same user")
    end
  end
end
