require 'rails_helper'

RSpec.describe Subscription, type: :model do
 describe 'relationships' do
    it { should belong_to(:user) } 
    it { should have_many(:tea_subscriptions) }
    it { should have_many(:teas).through(:tea_subscriptions) }
  end

  describe 'validations' do 
    it { should validate_presence_of :title }
    it { should validate_presence_of :status }
    it { should validate_presence_of :frequency }
    it { should validate_presence_of :user_id }
    it { should validate_numericality_of :frequency }
    it { should define_enum_for(:status).with_values([:active, :canceled])}
  end
end
