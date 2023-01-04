class Api::V1::SubscriptionController < ApplicationController 
  def create
    user = User.find(params[:user_id])
    subscription = Subscription.new(subscription_params)
    sub_teas = params[:teas].map {|tea_id| Tea.find(tea_id)}

    if subscription.save 
      subscription.teas << sub_teas
      render json: SubscriptionSerializer.new(subscription), status: :created
    end
  end

  private 

  def user_params
    params.permit(:user_id)
  end

  def subscription_params 
    params.permit(:title, :frequency, :user_id)
  end
end