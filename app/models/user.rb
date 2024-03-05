class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :invitee, class_name: 'User', foreign_key: :invited_by_id
  has_one :couple_as_partner_1, class_name: 'Couple', foreign_key: 'partner_1_id', dependent: :destroy
  has_one :couple_as_partner_2, class_name: 'Couple', foreign_key: 'partner_2_id', dependent: :destroy

  validate :only_one_couple

  private

  def only_one_couple
    if couple_as_partner_1 && couple_as_partner_2
      errors.add(:base, "A user can only be one type of partner in a couple.")
    end
  end
end
