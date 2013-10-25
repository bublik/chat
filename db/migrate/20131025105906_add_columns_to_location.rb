class AddColumnsToLocation < ActiveRecord::Migration
  def up
    add_column :locations, :platform, :string, :default => ''
    add_column :locations, :version, :string, :default => ''
    add_column :locations, :browser, :string, :default => ''
  end

  def down
    remove_column :locations, :platform
    remove_column :locations, :version
    remove_column :locations, :browser
  end
end
