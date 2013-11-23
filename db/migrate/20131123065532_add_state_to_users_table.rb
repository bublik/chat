class AddStateToUsersTable < ActiveRecord::Migration

  def up
    add_column :users, :state, :boolean, default: false
  end

  def down
    remove_column :users, :state
  end

end
