class AddStateColumnToSubscription < ActiveRecord::Migration
  def up
    add_column :subscriptions, :state, :string, default: 'active', null: false
  end

  def down
    remove_column :subscriptions, :state
  end
end
