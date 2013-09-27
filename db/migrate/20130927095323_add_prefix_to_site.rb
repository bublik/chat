class AddPrefixToSite < ActiveRecord::Migration
  def up
    add_column :sites, :user_prefix, :string, :default => 'guest'
  end

  def down
    remove_column :sites, :user_prefix
  end
end
