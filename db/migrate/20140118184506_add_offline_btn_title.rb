class AddOfflineBtnTitle < ActiveRecord::Migration
  def up
    rename_column :sites, :btn_title, :btn_title_online
    add_column :sites, :btn_title_offline, :string, default: 'Contact Us'
  end

  def down
    rename_column :sites, :btn_title_online, :btn_title
    remove_column :sites, :btn_title_offline
  end
end
