class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :invitee, class_name: 'User', foreign_key: :invited_by_id
  has_one :couple_as_partner1, class_name: 'Couple', foreign_key: 'partner1_id', dependent: :destroy
  has_one :couple_as_partner2, class_name: 'Couple', foreign_key: 'partner2_id', dependent: :destroy
end
