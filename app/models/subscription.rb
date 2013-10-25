# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  plan_id                        :integer
#  email                          :string(255)
#  stripe_customer_token          :string(255)
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#  created_at                     :datetime
#  updated_at                     :datetime
#  agent_id                       :integer          not null
#  state                          :string(255)      default("active"), not null
#

# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  plan_id                        :integer
#  email                          :string(255)
#  stripe_customer_token          :string(255)
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#  created_at                     :datetime
#  updated_at                     :datetime
#  agent_id                       :integer          not null
#  state                          :string(255)      default("active"), not null
#

class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :agent

  validates_presence_of :plan_id
  validates_presence_of :agent_id
  validates_presence_of :email
  validates_inclusion_of :state, in: [nil, 'active', 'suspended', 'canceled']

  attr_accessor :stripe_card_token, :paypal_payment_token

  def save_with_payment
    if valid?
      paypal? ? save_with_paypal_payment : save_with_stripe_payment
    end
  end

  def paypal
    PaypalPayment.new(self)
  end

  def paypal?
    paypal_payment_token.present? || paypal_customer_token.present?
  end

  def save_with_paypal_payment
    response = paypal.make_recurring
    if response.completed?
      self.paypal_recurring_profile_token = response.profile_id
      save!
    end
  end

  def suspend
    if self.paypal? ? paypal.suspend : raise('Not Implemented')
      self.update_attribute(:state, 'suspended')
    end
  end

  def reactivate
    if paypal? ? paypal.reactivate : raise('Not Implemented')
      update_attribute(:state, 'active')
    end
  end

  def cancel
    if paypal? ? paypal.cancel : stripe_customer.cancel_subscription({:at_period_end => 'true'})
      update_attribute(:state, 'canceled')
    end
  end

  def stripe_customer
    Stripe::Customer.retrieve(self.stripe_customer_token)
  end

  def save_with_stripe_payment
    customer = Stripe::Customer.create(description: email, plan: plan.name.downcase, card: stripe_card_token)
    self.stripe_customer_token = customer.id
    save!
  rescue Stripe::CardError => e
    logger.error "Stripe Card Error: #{e.message}"
    errors.add :base, e.message
    false
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe Invalid Request: #{e.message}"
    errors.add :base, e.message
    false
  end

  def payment_provided?
    stripe_card_token.present? || paypal_payment_token.present?
  end

  def available_methods
    if paypal?
      ['suspend', 'cancel'] if active?
      ['reactivate', 'cancel'] if suspended?
      ['subscribe'] if canceled?
    else
      ['cancel'] if active?
      ['subscribe'] if canceled?
    end
  end

  #Check state methods
  def active?
    self.state.eql?('active')
  end

  def suspended?
    self.state.eql?('suspended')
  end

  def canceled?
    self.state.eql?('canceled')
  end

end
