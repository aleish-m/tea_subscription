class Api::V1::SubscriptionController < ApplicationController 

  def index 
    user = User.find_by(id: params[:user_id])

    if user
      subscriptions = user.subscriptions
      render json: SubscriptionSerializer.new(subscriptions)
    else
      render json: SubscriptionSerializer.error(404, 'User must exist'), status: :not_found
    end
  end

  def create
    subscription = Subscription.new(subscription_params)
    sub_teas = tea_id_params.map {|tea_id| Tea.find(tea_id)}

    if subscription.save 
      subscription.teas << sub_teas
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: SubscriptionSerializer.error(400, subscription.errors.full_messages), status: :bad_request
    end
  end

  private 

  def tea_id_params 
    tea_ids = params.permit(:tea_ids)
    tea_ids[:tea_ids].split(',').map(&:to_i)
  end

  def subscription_params 
    params.permit(:title, :frequency, :user_id)
  end
end