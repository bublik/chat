class AddRoleToAgent < ActiveRecord::Migration
  def change
    add_column :agents, :role, :string
  end
end
