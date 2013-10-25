class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.string :user_usid
      t.string :remote_ip
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    # remove unused column
    remove_column :archive_collections, :remote_ip
  end

  def down
    remove_table :locations
    add_column :archive_collections, :remote_ip, :string
  end
end
