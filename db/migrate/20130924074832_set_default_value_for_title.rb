class SetDefaultValueForTitle < ActiveRecord::Migration
  def change
    change_column :sites, :title_online, :string, :default => ''
    change_column :sites, :title_offline, :string, :default => ''
    add_column :sites, :offline_welcome_message, :string, :default => ''
  end
end
