class AddAutoOpenSleep < ActiveRecord::Migration
  def up
    add_column :sites, :auto_open_timeout, :integer, :default => 3
  end

  def down
    remove_column :sites, :auto_open_timeout
  end
end
