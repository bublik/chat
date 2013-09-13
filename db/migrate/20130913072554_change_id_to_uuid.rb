class ChangeIdToUuid < ActiveRecord::Migration
  def up
    add_column :sites, :uuid, :binary, :null => false, :limit => 32
    Site.all.each do |site|
      site.save
    end
    add_index :sites, :uuid
  end

  def down
    remove_column :sites, :uuid
  end
end
