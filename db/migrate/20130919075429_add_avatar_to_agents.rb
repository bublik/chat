class AddAvatarToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :avatar, :string
  end
end
