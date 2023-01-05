class Subscription < ApplicationRecord
  belongs_to :user
  validates_associated :user
  has_many :teas_subscriptions
  has_many :teas, through: :teas_subscriptions

  enum status: { active: 0, cancelled: 1 }

  validates_presence_of :title, :status, :frequency, :user_id
  validates :frequency, numericality: true, inclusion: { in: 1..12, message: 'value is not within 1-12' }
end
