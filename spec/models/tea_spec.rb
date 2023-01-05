require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should have_many(:teas_subscriptions) }
    it { should have_many(:subscriptions).through(:teas_subscriptions) }
  end

  describe 'validations' do 
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :temperature }
    it { should validate_presence_of :brew_time }
    it { should validate_presence_of :price }
  end

  describe 'Model Methods' do
    describe '#total_cost' do
      it 'provides the sum of all tea prices' do
        tea_1 = create(:tea, price: 2.00)
        tea_1 = create(:tea, price: 3.00)
        tea_1 = create(:tea, price: 5.00)

        expect(Tea.total_cost).to eq(10.00)
      end
    end
  end
end

