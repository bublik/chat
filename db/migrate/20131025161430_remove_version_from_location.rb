class RemoveVersionFromLocation < ActiveRecord::Migration
  def up
    remove_column :locations, :version
  end

  def down
    add_column :locations, :version, :string
  end
end
