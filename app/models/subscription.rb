class Subscription < ApplicationRecord
  belongs_to :user

  enum status: {active: 0, canceled: 1}
  
  validates_presence_of :title, :status, :frequency, :user_id
  validates_numericality_of :frequency
end
