require 'rails_helper'

describe 'Update Subscriptions' do
  describe 'happy path' do
    it 'Can update subscription status from active to canceled' do
      user = create(:user)
      subscription = create(:subscription, status: 'active')

      params = {status: 'cancelled'}

      patch "/api/v1/users/#{user.id}/subscription/#{subscription.id}", params: params

      subscription_response = JSON.parse(response.body, symbolize_names: true)
      subscription_data = subscription_response[:data]

      updated_subscription = Subscription.find(subscription.id)

      expect(response).to be_successful
      expect(response).to have_http_status(201)

      expect(updated_subscription.status).to eq('cancelled')
      expect(updated_subscription.title).to eq(subscription.title)
      expect(updated_subscription.frequency).to eq(subscription.frequency)
      expect(updated_subscription.id).to eq(subscription.id)

      expect(subscription_response).to be_a(Hash)
      expect(subscription_response.count).to eq(1)

      expect(subscription_data[:id].to_i).to eq(subscription.id)
      expect(subscription_data[:type]).to eq('subscription')
      expect(subscription_data[:attributes].count).to eq(5)
      expect(subscription_data[:attributes][:title]).to eq(subscription.title)
      expect(subscription_data[:attributes][:status]).to eq('cancelled')
      expect(subscription_data[:attributes][:frequency]).to eq(subscription.frequency)
      expect(subscription_data[:attributes][:price]).to eq(Tea.total_cost)
      expect(subscription_data[:attributes][:created_at].to_date).to eq(subscription.created_at.to_date)
    end
  end
end