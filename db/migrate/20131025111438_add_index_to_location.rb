class AddIndexToLocation < ActiveRecord::Migration
  def up
    add_index :locations, :user_usid
  end

  def down
    remove_index :locations, :user_usid
  end
end
