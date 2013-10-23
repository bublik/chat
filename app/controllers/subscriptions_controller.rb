class SubscriptionsController < ApplicationController
  include Auth

  before_filter :find_subscription, :only => [:show, :suspend, :reactivate, :cancel]

  def index
    @subscriptions = current_agent.subscriptions.all
  end

  def new
    plan = Plan.find_by_id(params[:plan_id] || current_agent.plan_id)
    plan ||=  Plan.first
    @subscription = plan.subscriptions.build
    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.email = @subscription.paypal.checkout_details.email
    end
  end

  def create
    @subscription = Subscription.new(permit_params)
    @subscription.agent = current_agent
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => t('.thank_for_subscribing')
    else
      flash[:error] = @subscription.errors.full_messages.join('<br/>')
      render :new
    end
  end

  def show

  end

  def suspend
    @subscription.suspend
    redirect_to @subscription
  end

  def reactivate
    @subscription.reactivate
    redirect_to @subscription
  end

  def cancel
    @subscription.cancel
    redirect_to @subscription
  end

  def paypal_checkout
    plan = Plan.find(params[:plan_id])
    subscription = plan.subscriptions.build
    redirect_to subscription.paypal.checkout_url(
                    return_url: new_subscription_url(:plan_id => plan.id),
                    cancel_url: root_url
                )
  end

  private
  def permit_params
    params.require(:subscription).permit(:plan_id, :stripe_card_token, :paypal_customer_token, :paypal_payment_token, :email)
  end

  def find_subscription
    @subscription = current_agent.subscriptions.find(params[:id])
  end
end