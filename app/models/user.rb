class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :invitee, class_name: 'User', foreign_key: :invited_by_id
  has_one :couple_as_partner_1, class_name: 'Couple', foreign_key: 'partner_1_id', dependent: :destroy
  has_one :couple_as_partner_2, class_name: 'Couple', foreign_key: 'partner_2_id', dependent: :destroy

  has_many :couple_tasks_as_invited
  has_many :individual_tasks, dependent: :destroy
  has_many :missions, dependent: :destroy
  has_one :love_language, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: 'Noticed::Notification'

  validates_presence_of :first_name
end
