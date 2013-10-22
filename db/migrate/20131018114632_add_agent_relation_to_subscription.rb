class AddAgentRelationToSubscription < ActiveRecord::Migration
  def up
    add_column :subscriptions, :agent_id, :integer, :null => false
  end

  def down
    remove_column :subscriptions, :agent_id
  end
end
