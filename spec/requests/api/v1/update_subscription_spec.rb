require 'rails_helper'

describe 'Update Subscriptions' do
  describe 'happy path' do
    it 'Can update subscription status from active to canceled' do
      user = create(:user)
      subscription = create(:subscription, status: 'active')

      params = { status: 'cancelled' }

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

    it 'Can update many subscription attributes in one request' do
      user = create(:user)
      subscription = create(:subscription, status: 'active', frequency: 3)

      params = { status: 'cancelled',
                 title: 'Update Subscription Title',
                 frequency: 5 }

      patch "/api/v1/users/#{user.id}/subscription/#{subscription.id}", params: params

      subscription_response = JSON.parse(response.body, symbolize_names: true)
      subscription_data = subscription_response[:data]

      updated_subscription = Subscription.find(subscription.id)

      expect(response).to be_successful
      expect(response).to have_http_status(201)

      expect(updated_subscription.title).to eq('Update Subscription Title')
      expect(updated_subscription.title).to_not eq(subscription.title)
      expect(updated_subscription.frequency).to eq(5)
      expect(updated_subscription.frequency).to_not eq(subscription.frequency)
      expect(updated_subscription.status).to eq('cancelled')
      expect(updated_subscription.status).to_not eq(subscription.status)
      expect(updated_subscription.id).to eq(subscription.id)

      expect(subscription_data[:attributes][:title]).to eq(updated_subscription.title)
      expect(subscription_data[:attributes][:status]).to eq(updated_subscription.status)
      expect(subscription_data[:attributes][:frequency]).to eq(updated_subscription.frequency)
      expect(subscription_data[:attributes][:created_at].to_date).to eq(subscription.created_at.to_date)
    end
  end

  describe 'sad path' do
    it 'Will send a 400 error if update is not successful' do
      user = create(:user)
      subscription = create(:subscription, status: 'active', frequency: 3)

      params = {
        status: 'new',
        title: '',
        frequency: 'monthly'
      }

      patch "/api/v1/users/#{user.id}/subscription/#{subscription.id}", params: params

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      updated_subscription = Subscription.find(subscription.id)

      expect(response).to have_http_status(400)

      expect(updated_subscription).to eq(subscription)

      expect(subscription_response).to be_a(Hash)
      expect(subscription_response.count).to eq(2)

      expect(subscription_response).to have_key(:error)
      expect(subscription_response[:error]).to eq(400)
      expect(subscription_response).to have_key(:message)
      expect(subscription_response[:message]).to be_a(Array)
      expect(subscription_response).to eq({ error: 400,
                                            message: ["Title can't be blank", 'Frequency is not a number', 'Frequency value is not within 1-12',
                                                      "Status can only be 'active' or 'cancelled'"] })
    end
  end
end
