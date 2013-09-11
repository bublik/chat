class AddNameToAgentTable < ActiveRecord::Migration
  def up
    add_column :agents, :name, :string, :default => ''
  end

  def down
    remove_column :agents, :name
  end
end
