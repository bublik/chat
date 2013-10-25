class AddRemoteIpToArchiveCollection < ActiveRecord::Migration

  def up
    add_column :archive_collections, :remote_ip, :string, :default => ''
  end

  def down
      remove_column :archive_collections, :remote_ip
  end

end
