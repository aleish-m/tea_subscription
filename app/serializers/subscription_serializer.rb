class SubscriptionSerializer
  include JSONAPI::Serializer 
  attributes :title, :status, :frequency, :created_at
  attributes :price do |subscription|
    subscription.teas.total_cost
  end
end