class AddIndexToArchive < ActiveRecord::Migration
  def up
    add_index :archive_collections, :with_user
  end

  def down
    remove_index :archive_collections, :with_user
  end
end
