require 'rails_helper'

describe 'Create new Subscription' do
  describe 'happy path' do
    it 'Creates a new subscription for a user' do
      user = create(:user)
      teas = create_list(:tea, 5)

      params = {  title: 'New Subscription',
                  teas: teas.map {|tea| tea.id},
                  frequency: 2 }

      post "/api/v1/users/#{user.id}/subscription", params: params

      expect(response).to be_successful
      expect(response).to have_http_status(201)

      subscription_data = JSON.parse(response.body, symbolize_names: true)
      subscription = subscription_data[:data]

      created_subscription = user.subscriptions.last

      expect(created_subscription.title).to eq('New Subscription')
      expect(created_subscription.status).to eq("active")
      expect(created_subscription.frequency).to eq(params[:frequency])
      expect(created_subscription.teas).to eq(teas)

      expect(subscription_data).to be_a(Hash)
      expect(subscription_data.count).to eq(1)

      expect(subscription[:id].to_i).to eq(created_subscription.id)
      expect(subscription[:type]).to eq('subscription')
      expect(subscription[:attributes].count).to eq(5)
      expect(subscription[:attributes][:title]).to eq('New Subscription')
      expect(subscription[:attributes][:status]).to eq(created_subscription.status)
      expect(subscription[:attributes][:frequency]).to eq(created_subscription.frequency)
      expect(subscription[:attributes][:price]).to eq(Tea.total_cost)
      expect(subscription[:attributes][:created_at].to_date).to eq(created_subscription.created_at.to_date)
    end
  end

  describe 'sad path' do
    it 'It returns a 400 status code error if invalid user id is received' do
      user = create(:user)
      teas = create_list(:tea, 5)

      params = {  title: 'New Subscription',
                  teas: teas.map {|tea| tea.id},
                  frequency: 2 }

      post "/api/v1/users/#{user.id + 1}/subscription", params: params

      expect(response).to have_http_status(400)

      subscription_data = JSON.parse(response.body, symbolize_names: true)
  
      created_subscription = user.subscriptions.last

      expect(created_subscription).to eq(nil)


      expect(subscription_data).to be_a(Hash)
      expect(subscription_data.count).to eq(2)

      expect(subscription_data).to have_key(:error)
      expect(subscription_data[:error]).to eq(400)
      expect(subscription_data).to have_key(:message)
      expect(subscription_data[:message]).to be_a(Array)
      expect(subscription_data).to eq({ error: 400, message: ['User must exist'] })
    end

    it 'It returns a 400 status code error if required subscription fields are not received' do
      user = create(:user)
      teas = create_list(:tea, 5)

      params = { teas: teas.map {|tea| tea.id} }

      post "/api/v1/users/#{user.id}/subscription", params: params

      expect(response).to have_http_status(400)

      subscription_data = JSON.parse(response.body, symbolize_names: true)
  
      created_subscription = user.subscriptions.last

      expect(created_subscription).to eq(nil)


      expect(subscription_data).to be_a(Hash)
      expect(subscription_data.count).to eq(2)

      expect(subscription_data).to have_key(:error)
      expect(subscription_data[:error]).to eq(400)
      expect(subscription_data).to have_key(:message)
      expect(subscription_data[:message]).to be_a(Array)
      expect(subscription_data).to eq({ error: 400, message: ["Title can't be blank", "Frequency can't be blank", "Frequency is not a number", "Frequency is not included in the list"] })
    end
  end
end