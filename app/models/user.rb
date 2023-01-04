class User < ApplicationRecord
  has_many :subscriptions
  
  validates_presence_of :first_name, :last_name, :email, :address
  validates_uniqueness_of :email
end
