class ChangeDisabledColumnToEnables < ActiveRecord::Migration
  def up
    rename_column :sites, :disabled, :enabled
  end

  def down
    rename_column :sites, :enabled, :disabled
  end
end
