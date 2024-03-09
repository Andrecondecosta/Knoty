class Couple < ApplicationRecord
  belongs_to :partner_1, class_name: 'User'
  belongs_to :partner_2, class_name: 'User'
  has_many :couple_tasks, dependent: :destroy

  validate :different_partners

  private

  def different_partners
    errors.add(:base, "Partner 1 and Partner 2 cannot be the same user") if partner_1 == partner_2
  end
end
