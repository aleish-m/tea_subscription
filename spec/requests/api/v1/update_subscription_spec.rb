require 'rails_helper'

describe 'Update Subscriptions' do
  describe 'happy path' do
    it 'Can update subscription status from active to canceled' do
      user = create(:user)
      subscription = create(:subscription, status: 'active')

      params = {status: 'cancelled'}

      patch "/api/v1/users/#{user.id}/subscription/#{subscription.id}", params: params

      subscription_data = JSON.parse(response.body, symbolize_names: true)
      subscription = subscriptions_data[:data]

      updated_subscription = Subscription.find(subscription.id)

      expect(response).to be_successful
      expect(response).to have_http_status(201)

      expect(updated_subscription.status).to eq('cancelled')
      expect(updated_subscription.title).to eq(subscription.title)
      expect(updated_subscription.frequency).to eq(subscription.frequency)
      expect(updated_subscription.id).to eq(subscription.id)

      expect(subscription_data).to be_a(Hash)
      expect(subscription_data.count).to eq(1)

      expect(subscription[:id].to_i).to eq(subscription.id)
      expect(subscription[:type]).to eq('subscription')
      expect(subscription[:attributes].count).to eq(5)
      expect(subscription[:attributes][:title]).to eq('New Subscription')
      expect(subscription[:attributes][:status]).to eq('cancelled')
      expect(subscription[:attributes][:frequency]).to eq(subscription.frequency)
      expect(subscription[:attributes][:price]).to eq(Tea.total_cost)
      expect(subscription[:attributes][:created_at].to_date).to eq(created_subscription.created_at.to_date)

    end
  end
end