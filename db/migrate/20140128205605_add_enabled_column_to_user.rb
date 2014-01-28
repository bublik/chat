class AddEnabledColumnToUser < ActiveRecord::Migration

  def up
    add_column :users, :enabled, :boolean, default: true, null: false
  end

  def down
    remove_column :users, :enabled
  end

end
