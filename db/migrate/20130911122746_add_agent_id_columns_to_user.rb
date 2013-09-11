class AddAgentIdColumnsToUser < ActiveRecord::Migration

  def up
    add_column :users, :agent_id, :integer, :null => false
    add_index :users, :agent_id
  end

  def down
    remove_column :users, :agent_id
    remove_index :users, :agent_id
  end

end
