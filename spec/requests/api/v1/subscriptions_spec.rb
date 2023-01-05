require 'rails_helper'

describe 'View Subscriptions' do
  describe 'happy path' do
    it 'View all of a users Subscriptions' do
      user = create(:user)
      subscriptions = create_list(:subscription, 5, user: user)

      get "/api/v1/users/#{user.id}/subscriptions"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      subscriptions_data = JSON.parse(response.body, symbolize_names: true)
      subscriptions = subscriptions_data[:data]

      expect(subscriptions.count).to eq(5)

      subscriptions.each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription[:id]).to be_a(String)

        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to be_a(String)

        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to be_a(Hash)

        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes][:title]).to be_a(String)

        expect(subscription[:attributes]).to have_key(:status)
        expect(subscription[:attributes][:status]).to be_a(String)

        expect(subscription[:attributes]).to have_key(:frequency)
        expect(subscription[:attributes][:frequency]).to be_a(Integer)

        expect(subscription[:attributes]).to have_key(:price)
        expect(subscription[:attributes][:price]).to be_a(Float)

        expect(subscription[:attributes]).to have_key(:created_at)
        expect(subscription[:attributes][:created_at]).to be_a(String)

        expect(subscription).to_not have_key(:updated_at)
      end
    end

    describe 'sad path' do
      it 'sends a empty list if there are no subscriptions for a user' do
        user = create(:user)

        get "/api/v1/users/#{user.id}/subscriptions"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        subscriptions_data = JSON.parse(response.body, symbolize_names: true)

        expect(subscriptions_data[:data].count).to eq(0)

        expect(subscriptions_data[:data]).to be_an(Array)
      end

      it 'returns a 404 status code and a empty item hash when an invalid item id is requested' do
        user = create(:user)

        get "/api/v1/users/#{user.id + 1}/subscription"

        expect(response).to have_http_status(404)

        subscriptions_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(404)

        expect(subscriptions_data).to be_a(Hash)
        expect(subscriptions_data.count).to eq(2)

        expect(subscriptions_data).to have_key(:error)
        expect(subscriptions_data[:error]).to eq(404)
        expect(subscriptions_data).to have_key(:message)
        expect(subscriptions_data[:message]).to be_a(String)
        expect(subscriptions_data).to eq({ error: 404, message: 'User must exist' })
      end
    end
  end
end
