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

      created_subscription = user.subscription.last

      expect(created_subscription.title).to eq('New Subscription')
      expect(created_subscription.status).to eq("active")
      expect(created_subscription.frequency).to eq(params[:frequency])
      expect(created_subscription.teas).to eq([teas])

      expect(subscription_data).to be_a(Hash)
      expect(subscription_data.count).to eq(1)

      expect(subscription[:id].to_i).to eq(created_post.id)
      expect(subscription[:type]).to eq('subscription')
      expect(subscription[:attributes].count).to eq(5)
      expect(subscription[:attributes][:title]).to eq('New Subscription')
      expect(subscription[:attributes][:status]).to eq(created_subscription.post_status)
      expect(subscription[:attributes][:frequency]).to eq(created_subscription.description)
      expect(subscription[:attributes][:price]).to eq(created_subscription.tone)
      expect(subscription[:attributes][:created_at].to_date).to eq(created_subscription.created_at.to_date)
    end    
  end
end