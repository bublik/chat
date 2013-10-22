class CreateSubscriptions < ActiveRecord::Migration
  def up
    create_table :subscriptions do |t|
      t.integer "plan_id"
      t.string "email"
      t.string "stripe_customer_token"
      t.string "paypal_customer_token"
      t.string "paypal_recurring_profile_token"

      t.timestamps
    end
  end

  def down
    drop_table :subscriptions
  end
end
