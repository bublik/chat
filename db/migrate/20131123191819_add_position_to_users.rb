class AddPositionToUsers < ActiveRecord::Migration
  def up
    add_column :users, :position, :integer
  end

  def down
    remove_column :users, :position
  end
end
