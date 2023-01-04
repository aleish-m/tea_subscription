class Subscription < ApplicationRecord
  belongs_to :user
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions

  enum status: {active: 0, canceled: 1}

  validates_presence_of :title, :status, :frequency, :user_id
  validates :frequency, numericality: true, inclusion: 1..12
end
