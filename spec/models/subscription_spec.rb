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

require 'spec_helper'

describe Subscription do
  pending "add some examples to (or delete) #{__FILE__}"
end
