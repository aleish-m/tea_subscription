class Tea < ApplicationRecord
  has_many :teas_subscriptions
  has_many :subscriptions, through: :teas_subscriptions

  validates_presence_of :title, :description, :temperature, :brew_time, :price

  def self.total_cost
    sum(:price)
  end
end
